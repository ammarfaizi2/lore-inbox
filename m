Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268311AbUIWHsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268311AbUIWHsH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 03:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268314AbUIWHsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 03:48:07 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:3251 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268311AbUIWHsE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 03:48:04 -0400
Date: Thu, 23 Sep 2004 00:46:46 -0700
From: Paul Jackson <pj@sgi.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: miller@techsource.com, jgarzik@pobox.com, dwmw2@infradead.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, jeremy@sgi.com
Subject: Re: [DOC] Linux kernel patch submission format
Message-Id: <20040923004646.33c372f7.pj@sgi.com>
In-Reply-To: <200409221947.i8MJlnSX003715@laptop11.inf.utfsm.cl>
References: <4151CBA2.1020005@techsource.com>
	<200409221947.i8MJlnSX003715@laptop11.inf.utfsm.cl>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> diff(1) does what you want...

Not all he wanted.  There's more to a patch than the diff.

The following three documents explain how to submit patches to the
Linux kernel:

 1) Documentation/SubmittingPatches, a file in the kernel source
 2) Andrew Morton's "The Perfect Patch", available at:
      http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt
 3) Jeff Garzik's "Linux kernel patch submission format", at:
      http://linux.yyz.us/patch-format.html

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
