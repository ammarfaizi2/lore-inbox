Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136824AbRECOq5>; Thu, 3 May 2001 10:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136825AbRECOqr>; Thu, 3 May 2001 10:46:47 -0400
Received: from tango.SoftHome.net ([204.144.231.49]:32231 "HELO
	tango.SoftHome.net") by vger.kernel.org with SMTP
	id <S136824AbRECOqm>; Thu, 3 May 2001 10:46:42 -0400
Message-ID: <002d01c0d3e0$1f4d5270$7253e59b@megatrends.com>
Reply-To: "Venkatesh Ramamurthy" <venkateshr@ami.com>
From: "Venkatesh Ramamurthy" <venkateshr@softhome.net>
To: <rafael@viewpoint.no>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <auto-000000185389@viventus.no>
Subject: Re: Solution - AMI  megaraid driver doesn't work with Linux 2.4.x kernels
Date: Thu, 3 May 2001 10:48:29 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you provide the dmesg output of your system after loading the driver
either successfully or unsucessfully.

----- Original Message -----
From: "Rafael Martinez" <rafael@viewpoint.no>
To: <linux-kernel@vger.kernel.org>
Sent: Thursday, May 03, 2001 11:37 AM
Subject: Solution - AMI megaraid driver doesn't work with Linux 2.4.x
kernels


> Hei
>
> The Ami megatrends driver (at least for 471, 475, and 493) does not work
> with 2.4.x kernels.
>
> The solution we got from Ami is to update the firmware of these cards to
> version FW G158. This update will fix all the problems with ami
> raid-devices in 2.4.x kernel without changing the driver.
>
> We don't know when AMI will release a fixed firmware (hope soon) but we
got it by
> e-mail. If there is anybody with the same problem I can sent the
> firmware-update by mail.
>
> Sincerely
> Rafael Martinez
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

