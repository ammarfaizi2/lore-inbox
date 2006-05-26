Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030480AbWEZFrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030480AbWEZFrK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 01:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030478AbWEZFrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 01:47:10 -0400
Received: from terminus.zytor.com ([192.83.249.54]:47078 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030477AbWEZFrI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 01:47:08 -0400
Message-ID: <44769656.8020507@zytor.com>
Date: Thu, 25 May 2006 22:47:02 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org, mm-commits@vger.kernel.org
Subject: Re: - git-klibc-build-hacks.patch removed from -mm tree
References: <200605252358.k4PNwQ8R015702@shell0.pdx.osdl.net>
In-Reply-To: <200605252358.k4PNwQ8R015702@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm@osdl.org wrote:
> git-klibc-stdint-build-fix.patch
> git-klibc-stdint-build-fix-2.patch

These two patches should no longer be necessary against the latest klibc 
tree.  I have compile-tested sparc32 (don't have a working sparc32 
system at the moment, so I haven't been able to boot-test it), and it 
compiles clean.

	-hpa
