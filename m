Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267554AbUI1L7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267554AbUI1L7f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 07:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267657AbUI1L7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 07:59:35 -0400
Received: from web53908.mail.yahoo.com ([206.190.36.218]:31586 "HELO
	web53908.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267554AbUI1L7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 07:59:34 -0400
Message-ID: <20040928115933.61635.qmail@web53908.mail.yahoo.com>
Date: Tue, 28 Sep 2004 04:59:33 -0700 (PDT)
From: Fawad Lateef <fawad_lateef@yahoo.com>
Subject: facing prob related to 2.6.x kernel ............
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I m using Fedora Core 2 (2.6.8.1) on XEON 2.2GHz SMP
Machine with 8GB RAM. When I boot my system with the
kernel 2.6.5 or on 2.6.8.1 without SMP and HIGHMEM64G
support it boots fine, but when I boot with SMP and
HIGHMEM64 enabled on 2.6.8.1 or 2.6.5, the booting
process becomes tooo slow i.e. took almost 20 or
minutes to boot. 

The Same kernel configuration on the other machine
having same hardware configuration (except have 2GB
RAM in other machine not 8GB) works well. 

The machine creating problem is working fine with
kernel 2.4.25 or so ............ 

Please do help me ..........

Fawad Lateef

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
