Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266114AbUBJUde (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 15:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266128AbUBJUdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 15:33:33 -0500
Received: from [65.248.107.127] ([65.248.107.127]:1152 "EHLO
	ns1.brianandsara.net") by vger.kernel.org with ESMTP
	id S266114AbUBJUdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 15:33:32 -0500
From: Brian Jackson <iggy@gentoo.org>
Organization: Gentoo Linux
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.3-rc1-mm1
Date: Tue, 10 Feb 2004 13:45:19 -0600
User-Agent: KMail/1.6.50
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20040209014035.251b26d1.akpm@osdl.org>
In-Reply-To: <20040209014035.251b26d1.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402101345.19015.iggy@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel bug at mm/slab.c:1107!
invalid operand:0000 [#1]
SMP

(this happened just after the Console: and Memory: lines)
This didn't happen with 2.6.1-mm4 (that's the last -mm I tried). I can try to 
track down where it started later, but this is my firewall, so I have to wait 
till everyone goes to sleep first.

--Iggy

On Monday 09 February 2004 03:40, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3-rc1/2.6
>.3-rc1-mm1/
>
>


-- 
Home -- http://www.brianandsara.net
Gentoo -- http://gentoo.brianandsara.net
