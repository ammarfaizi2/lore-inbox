Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290170AbSAKXuI>; Fri, 11 Jan 2002 18:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290172AbSAKXt6>; Fri, 11 Jan 2002 18:49:58 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:24735 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S290170AbSAKXto>;
	Fri, 11 Jan 2002 18:49:44 -0500
Date: Fri, 11 Jan 2002 23:49:39 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: jt@hpl.hp.com, Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [PATCH] wavelan_cs update (Pcmcia backport)
Message-ID: <1563806246.1010792978@[195.224.237.69]>
In-Reply-To: <20020111151825.C15515@bougret.hpl.hp.com>
In-Reply-To: <20020111151825.C15515@bougret.hpl.hp.com>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	I was playing with wavelan_cs in the kernel (converting it to
> the new Wireless Extensions), and I realised that it doesn't work at
> all. I had a look at the code and it is so antique that it is scary.

Don't suppose you'd like to backport the non-pcmcia (i.e. true
PCI, not pcmcia on a PCI minibridge) version too? I will happilly
test it for you (IBM T23).

--
Alex Bligh
