Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266745AbUGLHHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266745AbUGLHHO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 03:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266746AbUGLHHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 03:07:14 -0400
Received: from delta.ds3.agh.edu.pl ([149.156.124.3]:55314 "EHLO
	pluto.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S266745AbUGLHGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 03:06:03 -0400
From: =?iso-8859-2?q?Pawe=B3_Sikora?= <pluto@ds14.agh.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [ppc] `unknown symbol' in drivers/scsi/pcmcia/fdomain_cs.ko
Date: Mon, 12 Jul 2004 09:06:03 +0200
User-Agent: KMail/1.6.2
References: <200407120734.16767.pluto@pld-linux.org>
In-Reply-To: <200407120734.16767.pluto@pld-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200407120906.03225.pluto@ds14.agh.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 of July 2004 07:34, you wrote:
> drivers/scsi/pcmcia/fdomain_cs.ko needs unknown symbol isa_memcpy_fromio
> drivers/scsi/pcmcia/fdomain_cs.ko needs unknown symbol isa_readb
>
> iirc the isa bus isn't available on ppc.

oops, my fault, CHRP IBM,7046-B50 has isa bus.

-- 
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)
