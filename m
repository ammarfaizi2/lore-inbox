Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266073AbUALHFf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 02:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266076AbUALHFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 02:05:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:3473 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266073AbUALHFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 02:05:31 -0500
Date: Sun, 11 Jan 2004 23:05:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: gene.heskett@verizon.net
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm1: drivers/video/sis/sis_main.c link error
Message-Id: <20040111230526.72780162.akpm@osdl.org>
In-Reply-To: <200401120147.36032.gene.heskett@verizon.net>
References: <20040109014003.3d925e54.akpm@osdl.org>
	<20040111214259.568cff35.akpm@osdl.org>
	<200401120611.i0C6BH7c003591@turing-police.cc.vt.edu>
	<200401120147.36032.gene.heskett@verizon.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gene.heskett@verizon.net> wrote:
>
>  Or maybe not, what do I do when "vmstat 1" prints its column headers and segfaults?:

You probably need a new vmstat.  There were quite a few buggy ones around. 
Make sure you have a current procps.


