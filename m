Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbTE1VXq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 17:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbTE1VXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 17:23:46 -0400
Received: from va-leesburg1b-227.stngva.adelphia.net ([68.64.41.227]:50055
	"EHLO ccs.covici.com") by vger.kernel.org with ESMTP
	id S261161AbTE1VXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 17:23:45 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16085.11257.992638.629349@ccs.covici.com>
Date: Wed, 28 May 2003 17:36:57 -0400
From: John covici <covici@ccs.covici.com>
To: "ismail (cartman) donmez" <kde@myrealbox.com>
Cc: covici@ccs.covici.com, linux-kernel@vger.kernel.org
Subject: Re: peculiar alsa problems in 2.5.70
In-Reply-To: <200305282337.20169.kde@myrealbox.com>
References: <m38ysravhp.fsf@ccs.covici.com>
	<200305282219.36472.kde@myrealbox.com>
	<16085.4152.541068.146164@ccs.covici.com>
	<200305282337.20169.kde@myrealbox.com>
X-Mailer: VM 7.15 under Emacs 21.3.50.3
Reply-To: covici@ccs.covici.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I do an alsactl restore without unloading the module I get no
message, but if I actually shut down the sound driver (stop and
start) I get the messages again.

on Wednesday 05/28/2003 ismail (cartman) donmez(kde@myrealbox.com) wrote
 > On Wednesday 28 May 2003 22:38, John covici wrote:
 > > When I did the alsactl store I got a file with two "cards" one says
 > > state.via8233 and the other says state.'"via8233"' and the id on the
 > > via82xx options line is via8233 -- so I am not sure what this means.
 > >
 > Do you still get error msgs from alsactl ?
 > 
 > Regards,
 > /ismail

-- 
         John Covici
         covici@ccs.covici.com
