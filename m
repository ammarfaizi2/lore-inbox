Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263973AbTFDUcT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 16:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264050AbTFDUcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 16:32:19 -0400
Received: from sj-core-4.cisco.com ([171.68.223.138]:57547 "EHLO
	sj-core-4.cisco.com") by vger.kernel.org with ESMTP id S263973AbTFDUbN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 16:31:13 -0400
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "'P. Benie'" <pjb1008@eng.cam.ac.uk>,
       "'Linus Torvalds'" <torvalds@transmeta.com>
Cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] [2.5] Non-blocking write can block
Date: Wed, 4 Jun 2003 13:43:50 -0700
Organization: Cisco Systems
Message-ID: <01e901c32ada$011de780$ca41cb3f@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
Importance: Normal
In-Reply-To: <Pine.HPX.4.33L.0306041937290.18475-100000@punch.eng.cam.ac.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, yes, that patch is already in 2.5. It got merged in 2.4 sometime
between 2.4.17 and 2.4.20..

> I compared 2.4.20 and 2.5.70 to see if I could find the patch Hua
> referred to. n_tty.c and pty.c look almost the same - I don't 
> think the
> patch is in 2.4.20.
> 
> Peter
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

