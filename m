Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264840AbTE1TPJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 15:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264839AbTE1TPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 15:15:08 -0400
Received: from [62.29.84.157] ([62.29.84.157]:641 "EHLO submoron.org")
	by vger.kernel.org with ESMTP id S264840AbTE1TPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 15:15:03 -0400
From: "ismail (cartman) donmez" <kde@myrealbox.com>
Organization: Bogazici University
To: John Covici <covici@ccs.covici.com>, linux-kernel@vger.kernel.org
Subject: Re: peculiar alsa problems in 2.5.70
Date: Wed, 28 May 2003 22:19:36 +0300
User-Agent: KMail/1.5.9
References: <m38ysravhp.fsf@ccs.covici.com>
In-Reply-To: <m38ysravhp.fsf@ccs.covici.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
   =?ISO-8859-1?Q?=20charset=3D=22=FDso-885?= =?ISO-8859-1?Q?9-9=22?=
Content-Transfer-Encoding: 7bit
Message-Id: <200305282219.36472.kde@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 May 2003 19:25, John Covici wrote:
> I am using via82xx and I have all the alsa stuff configured as
> modules and every time I do  /etc/init.d/alsasound start I get the
> following:
>
> Starting sound driver: snd-via82xx done
> /usr/sbin/alsactl: set_control:780: failed to obtain info for control
> #37 (No such file or directory)
> /usr/sbin/alsactl: set_control:780: failed to obtain info for control
> #38 (No such file or directory)
> /usr/sbin/alsactl: set_control:780: failed to obtain info for control
> #39 (No such file or directory)
>
> Any assistance would be appreciated.

Try  alsactl store on cli. See if that helps.

Regards,
/ismail 
