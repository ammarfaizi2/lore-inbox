Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310584AbSCGW6I>; Thu, 7 Mar 2002 17:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310582AbSCGW57>; Thu, 7 Mar 2002 17:57:59 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:57838 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S310585AbSCGW5k>; Thu, 7 Mar 2002 17:57:40 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <E16j70R-000463-00@the-village.bc.nu> 
In-Reply-To: <E16j70R-000463-00@the-village.bc.nu> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: phillips@bonn-fries.net (Daniel Phillips), yodaiken@fsmlabs.com,
        jdike@karaya.com (Jeff Dike), bcrl@redhat.com (Benjamin LaHaise),
        hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 07 Mar 2002 22:57:12 +0000
Message-ID: <1916.1015541832@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
>  None at all. If you needed the memory before you committed to an
> operation you should have reserved it before you started. See "sloppy
> coders"

This is true. I must admit I was having trouble trying to think of a real 
case where the latter applied in _sane_ code.

--
dwmw2


