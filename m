Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264844AbTE1TZd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 15:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264848AbTE1TZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 15:25:33 -0400
Received: from va-leesburg1b-227.stngva.adelphia.net ([68.64.41.227]:10118
	"EHLO ccs.covici.com") by vger.kernel.org with ESMTP
	id S264844AbTE1TZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 15:25:31 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16085.4152.541068.146164@ccs.covici.com>
Date: Wed, 28 May 2003 15:38:32 -0400
From: John covici <covici@ccs.covici.com>
To: "ismail (cartman) donmez" <kde@myrealbox.com>
Cc: John Covici <covici@ccs.covici.com>, linux-kernel@vger.kernel.org
Subject: Re: peculiar alsa problems in 2.5.70
In-Reply-To: <200305282219.36472.kde@myrealbox.com>
References: <m38ysravhp.fsf@ccs.covici.com>
	<200305282219.36472.kde@myrealbox.com>
X-Mailer: VM 7.15 under Emacs 21.3.50.3
Reply-To: covici@ccs.covici.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I did the alsactl store I got a file with two "cards" one says
state.via8233 and the other says state.'"via8233"' and the id on the
via82xx options line is via8233 -- so I am not sure what this means.

on Wednesday 05/28/2003 ismail (cartman) donmez(kde@myrealbox.com) wrote
 > On Wednesday 28 May 2003 19:25, John Covici wrote:
 > > I am using via82xx and I have all the alsa stuff configured as
 > > modules and every time I do  /etc/init.d/alsasound start I get the
 > > following:
 > >
 > > Starting sound driver: snd-via82xx done
 > > /usr/sbin/alsactl: set_control:780: failed to obtain info for control
 > > #37 (No such file or directory)
 > > /usr/sbin/alsactl: set_control:780: failed to obtain info for control
 > > #38 (No such file or directory)
 > > /usr/sbin/alsactl: set_control:780: failed to obtain info for control
 > > #39 (No such file or directory)
 > >
 > > Any assistance would be appreciated.
 > 
 > Try  alsactl store on cli. See if that helps.
 > 
 > Regards,
 > /ismail 

-- 
         John Covici
         covici@ccs.covici.com
