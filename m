Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283675AbRLDOo3>; Tue, 4 Dec 2001 09:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283134AbRLDOnD>; Tue, 4 Dec 2001 09:43:03 -0500
Received: from [165.139.124.200] ([165.139.124.200]:47289 "EHLO
	xinul2.hobart.k12.in.us") by vger.kernel.org with ESMTP
	id <S283433AbRLDNGR>; Tue, 4 Dec 2001 08:06:17 -0500
From: "Russell Mellon" <mellonr@hobart.k12.in.us>
To: "Stefan Smietanowski" <stesmi@stesmi.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: IP address 10.1.1.0/16 not valid
Date: Tue, 4 Dec 2001 07:07:07 -0600
Message-ID: <PDEDJCHJOFMEOMMKOPDGGEDNCLAA.mellonr@hobart.k12.in.us>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <3C0C93DB.2040909@stesmi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, you are right, it was about 3am when I wrote the message...
Still, the kernel should allow the address 10.1.1.0/16.
-Russ

-----Original Message-----
From: Stefan Smietanowski [mailto:stesmi@stesmi.com]
Sent: Tuesday, December 04, 2001 3:14 AM
To: Russell Mellon
Cc: linux-kernel@vger.kernel.org
Subject: Re: IP address 10.1.1.0/16 not valid


Russell Mellon wrote:

> Why is it that the kernel seems to reject using the address 10.1.1.0 on a
> 255.255.0.0 netmask.  That address isn't the broadcast address, 10.1.0.0
is.


To be pendantic, 10.1.0.0 is the network address and 10.1.255.255 is the
broadcast :)

// Stefan

