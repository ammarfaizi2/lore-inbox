Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbVGEMgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbVGEMgE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 08:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbVGEMgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 08:36:03 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:13720
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261818AbVGEM36 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 08:29:58 -0400
Reply-To: <abonilla@linuxwireless.org>
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: "'Jens Axboe'" <axboe@suse.de>
Cc: <hdaps-devel@lists.sourceforge.net>,
       "'LKML List'" <linux-kernel@vger.kernel.org>
Subject: RE: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested? (Accelerometer))
Date: Tue, 5 Jul 2005 06:29:48 -0600
Message-ID: <000701c5815d$3c29c840$600cc60a@amer.sykes.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20050705071449.GV1444@suse.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> As Lenz already suggested, you both pretty much seem to be describing
> laptop mode. See the documentation.
>
> --
> Jens Axboe
>
Jens,

	Yes, I know about laptop_mode, I always use it, but HD APS does not
automatically starts laptop_mode currently. That's why I was spitting out
that it could be a good idea to kick something like laptop_mode or
laptop_mode if normall vibration is detected, and then if higher vibration
or tilting numbers are detected, then park the head.

	If you check the IBM software in Windows, it shows 2 things. First, when it
pauses the HD and when it stops the HD. It all depends on how hard you hit
the PC. In one we suspend the drive and in the other we park the drive.

.Alejandro
(removing some people so they don't get triplicated emails)

