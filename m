Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314468AbSEBOp7>; Thu, 2 May 2002 10:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314490AbSEBOp6>; Thu, 2 May 2002 10:45:58 -0400
Received: from mail02.svc.cra.dublin.eircom.net ([159.134.118.18]:56081 "HELO
	mail02.svc.cra.dublin.eircom.net") by vger.kernel.org with SMTP
	id <S314468AbSEBOp5>; Thu, 2 May 2002 10:45:57 -0400
Message-ID: <000701c1f1e8$739cff20$a07fa8c0@mofo>
From: "Jarlath Burke" <burkejarlath@eircom.net>
To: <davem@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: RARP server support on Linux 2.4
Date: Thu, 2 May 2002 15:48:41 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reply - I'm still somewhat confused.

Is all I have to do is add hardware to IP address
mappings in /etc/ethers and the rarpd daemon
will pick them up and add them to the kernel?

Is there any way to monitor what the kernel has
in it's rarp cache, similiar to running the rarp command
on the old 2.2.x kernels?

Thanks in advance,
Jarlath.

> -----Original Message-----
> From: David S. Miller [mailto:davem@redhat.com]
> Sent: 08 April 2002 16:55
> To: jarlath.burke@asitatech.com
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: RARP server support on Linux 2.4
> 
> 
> 
> You have to maintain the ethernet address to IP address database
> in /etc/ethers.

