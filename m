Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751603AbWIUVkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbWIUVkM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 17:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751609AbWIUVkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 17:40:12 -0400
Received: from mail.gurulabs.com ([67.137.148.7]:2485 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S1751603AbWIUVkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 17:40:10 -0400
Subject: Re: Smaller compressed kernel source tarballs?
From: Dax Kelson <dax@gurulabs.com>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060921204250.GN13641@csclub.uwaterloo.ca>
References: <1158870777.24172.23.camel@mentorng.gurulabs.com>
	 <20060921204250.GN13641@csclub.uwaterloo.ca>
Content-Type: text/plain
Date: Thu, 21 Sep 2006 15:40:09 -0600
Message-Id: <1158874809.24172.45.camel@mentorng.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-21 at 16:42 -0400, Lennart Sorensen wrote:
> But after you download it once, you can just get the diff next time.
> How is the decompression time on 7zip versus bzip2 and gzip?

Decompression times on 2.6.18 are as follows:

gzip:   0m3.509s
7zip:   0m10.012s
bzip2:  0m22.703s

Dax Kelson

