Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030192AbWARIhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbWARIhP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 03:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbWARIhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 03:37:14 -0500
Received: from holomorphy.com ([66.93.40.71]:42436 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S1030192AbWARIhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 03:37:13 -0500
Date: Wed, 18 Jan 2006 00:37:10 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: HuaFeijun <hua.feijun@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hugetlb bug
Message-ID: <20060118083710.GE13708@holomorphy.com>
References: <3fe1d240601180000n511f9697m@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fe1d240601180000n511f9697m@mail.gmail.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 04:00:03PM +0800, HuaFeijun wrote:
> Is it kernel bug? The code works normally on ia64 machine,howerver, on
> EM64T,it fails tot work.
> The function call of shmat will change /proc/meminfo;and  the shmdt
> can't restore it to original content.  How to restore it to original
> stauts?Thanks.
> Is it kernel bug? The code works normally on ia64 machine,howerver,
> on EM64T,it fails tot work. The function call of shmat will change
> /proc/meminfo file's content;and  the shmdt can't restore the file's
> content.  How to restore it to original stauts?Thanks.

Kernel versions for EM64T and ia64?


-- wli
