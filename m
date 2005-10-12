Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbVJLVKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbVJLVKl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 17:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbVJLVKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 17:10:41 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:53007 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id S964808AbVJLVKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 17:10:40 -0400
From: Felix Oxley <lkml@oxley.org>
To: jerome lacoste <jerome.lacoste@gmail.com>
Subject: Re: Linux Kernel Dump Summit 2005
Date: Wed, 12 Oct 2005 22:10:32 +0100
User-Agent: KMail/1.8.2
Cc: Pavel Machek <pavel@suse.cz>, OBATA Noboru <noboru.obata.ar@hitachi.com>,
       hyoshiok@miraclelinux.com, linux-kernel@vger.kernel.org
References: <20051010084535.GA2298@elf.ucw.cz> <200510121056.48429.lkml@oxley.org> <5a2cf1f60510120405n6bd03776w1995bb45269b37d8@mail.gmail.com>
In-Reply-To: <5a2cf1f60510120405n6bd03776w1995bb45269b37d8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510122210.35180.lkml@oxley.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 October 2005 12:05, jerome lacoste wrote:
>
> But in the LZF case, there's 100 M more memory in the cache. That
> certainly has some I/O perf. impact, right?
>

mm.. well spotted.
It would be better if both measurements were taken from the same starting 
point, e.g. immediately after boot.
