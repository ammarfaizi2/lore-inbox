Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267588AbUHaJGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267588AbUHaJGU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 05:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267585AbUHaJGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 05:06:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:57996 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267588AbUHaJFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 05:05:54 -0400
Date: Tue, 31 Aug 2004 02:04:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Yuval Turgeman <yuvalt@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: searching for parameters in 'make menuconfig'
Message-Id: <20040831020403.7a78492b.akpm@osdl.org>
In-Reply-To: <9ae345c004083002282ec691a9@mail.gmail.com>
References: <9ae345c004083002282ec691a9@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yuval Turgeman <yuvalt@gmail.com> wrote:
>
> I added the ability to search for parameters in make menuconfig (find
>  a given parameter's location in the tree).

Well that beats grepping the Kconfig files.  Thanks - I just used it.

I extensively reworked your code layout.  Please follow
Documentation/CodginStyle, and the surrounding code in future.

