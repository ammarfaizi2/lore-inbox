Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267532AbTBFXMP>; Thu, 6 Feb 2003 18:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267534AbTBFXMO>; Thu, 6 Feb 2003 18:12:14 -0500
Received: from maild.telia.com ([194.22.190.101]:2301 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id <S267532AbTBFXMK> convert rfc822-to-8bit;
	Thu, 6 Feb 2003 18:12:10 -0500
X-Original-Recipient: linux-kernel@vger.kernel.org
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: gcc -O2 vs gcc -Os performance
Date: Fri, 7 Feb 2003 00:17:17 +0100
User-Agent: KMail/1.5.9
References: <336780000.1044313506@flay> <1044553691.10374.20.camel@irongate.swansea.linux.org.uk> <263740000.1044563891@[10.10.2.4]>
In-Reply-To: <263740000.1044563891@[10.10.2.4]>
MIME-Version: 1.0
Content-Disposition: inline
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200302070017.18067.roger.larsson@skelleftea.mail.telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 February 2003 21:38, Martin J. Bligh wrote:
> gcc-3.2
> 
> 2901299 vmlinux.O2
> 2667827 vmlinux.Os
>

In an earlier message, Martin J. Bligh wrote: 
>
> 894822 Feb  5 23:50 /boot/vmlinuz-2.5.59-mjb3-Os
> 906203 Feb  5 22:46 /boot/vmlinuz-2.5.59-mjb3.old

And if you compare both with  same/no  compression?

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden

