Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265773AbUIAJPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265773AbUIAJPv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 05:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265795AbUIAJPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 05:15:51 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:61668 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S265773AbUIAJPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 05:15:49 -0400
Message-ID: <7f800d9f04090102152e4a2fe2@mail.gmail.com>
Date: Wed, 1 Sep 2004 02:15:46 -0700
From: Andre Eisenbach <int2str@gmail.com>
Reply-To: Andre Eisenbach <int2str@gmail.com>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.6.9-rc1-mm2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20040901072525.GX5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040830235426.441f5b51.akpm@osdl.org> <7f800d9f040901001551f92762@mail.gmail.com> <20040901072525.GX5492@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Sep 2004 00:25:25 -0700, William Lee Irwin III
<wli@holomorphy.com> wrote:
> Please apply the following fixes:
> 
> Index: mm2-2.6.9-rc1/include/linux/wait.h
> Index: mm2-2.6.9-rc1/kernel/wait.c

Applying those patches worked.

Thanks,
   Andre
