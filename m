Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbUBNJip (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 04:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbUBNJip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 04:38:45 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:25476 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S261522AbUBNJio
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 04:38:44 -0500
Date: Sat, 14 Feb 2004 10:38:00 +0100
From: Marco Roeland <marco.roeland@xs4all.nl>
To: yiding_wang@agilent.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: what is the best 2.6.2 kernel code?
Message-ID: <20040214093800.GA32714@localhost>
References: <0A78D025ACD7C24F84BD52449D8505A15A80CF@wcosmb01.cos.agilent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <0A78D025ACD7C24F84BD52449D8505A15A80CF@wcosmb01.cos.agilent.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday february 13 th 2004 yiding_wang@agilent.com wrote:

> I downloaded kernel linux-2.6.2.tar.gz and patch-2.6.2.bz2 from kernel
> source. Both files are dated 03-Feb.-2004.
>
> Building new kernel from the source failed on fs/proc/array.o.

This is a known compiler bug for gcc 2.96. See the following link for a
workaround patch, or upgrade your compiler.

http://marc.theaimsgroup.com/?l=linux-kernel&m=107567013416122&w=2
-- 
Marco Roeland
