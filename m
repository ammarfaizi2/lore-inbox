Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129468AbRBCC05>; Fri, 2 Feb 2001 21:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130303AbRBCC0t>; Fri, 2 Feb 2001 21:26:49 -0500
Received: from [200.222.195.185] ([200.222.195.185]:35460 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id <S129468AbRBCC0i>; Fri, 2 Feb 2001 21:26:38 -0500
Date: Sat, 3 Feb 2001 00:24:55 -0200
From: Frédéric L. W. Meunier <0@pervalidus.net>
To: virii <virii@gcecisp.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: svgalib problem
Message-ID: <20010203002455.L160@pervalidus.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.14i
X-Mailer: Mutt/1.3.14i - Linux 2.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> svgalib: mmap error in paged screen memory. 

A fix is to build SVGAlib without background execution support.

Take a look at http://www.arava.co.il/matan/svgalib/hypermail/

-- 
Frédéric L. W. Meunier - http://www.pervalidus.net/
0@pervalidus.{net, {dyndns.}org} Tel: 55-21-717-2399 (Niterói-RJ BR)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
