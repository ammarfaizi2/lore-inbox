Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261922AbVGEQKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbVGEQKJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 12:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbVGEQGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 12:06:13 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:46050
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261904AbVGEPwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 11:52:50 -0400
Reply-To: <abonilla@linuxwireless.org>
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: <sander@humilis.net>, "'Alejandro Bonilla'" <abonilla@linuxwireless.org>
Cc: "'Jens Axboe'" <axboe@suse.de>, <hdaps-devel@lists.sourceforge.net>,
       "'LKML List'" <linux-kernel@vger.kernel.org>
Subject: RE: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested? (Accelerometer))
Date: Tue, 5 Jul 2005 09:52:39 -0600
Message-ID: <002001c58179$92d7a880$600cc60a@amer.sykes.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20050705154119.GB27286@favonius>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alejandro Bonilla wrote (ao):
> > 	If you check the IBM software in Windows, it shows 2 things.
> > 	First, when it pauses the HD and when it stops the HD. It all
> > 	depends on how hard you hit the PC. In one we suspend the drive
> > 	and in the other we park the drive.
>
> This is not true. The software only parks the head, it does not spin
> down the disk. That would take too much time to protect against a fall
> anyway.
>
>         Sander

Sander,

	Sorry for not making myself clear "In one we suspend the drive and in the
other we park the drive" means that it would be nice to do that in Linux. We
don't have to do things like Windows does them. We can improve them to our
needs.

	In windows, there are 2 Simbols. 1. When the drive detects vibration and
then pauses the HD(yellow II sign in the taskbar) 2. When the HD is stop
when a free fall is detected. (Red simbol in the Taskbar)

	Please check it out in windows so you can see what I'm talking about.

.Alejandro

