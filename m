Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbTICBii (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 21:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263916AbTICBii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 21:38:38 -0400
Received: from mailhub2.uq.edu.au ([130.102.5.59]:65199 "EHLO
	mailhub2.uq.edu.au") by vger.kernel.org with ESMTP id S261817AbTICBig convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 21:38:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Stuart Low <stuart@perlboy.org>
Organization: Perlboy.org
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [DEBUG] 2.6.0-test4 - sleeping function called from invalid context
Date: Wed, 3 Sep 2003 11:46:54 +1000
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <1062520736.2331.10.camel@poohbox.perlaholic.com> <20030902173320.GM4306@holomorphy.com>
In-Reply-To: <20030902173320.GM4306@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200309031146.54406.stuart@perlboy.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And the lost_journal errors?

It's happened 3 times in 24 hours now.

Stuart


On Wed, 3 Sep 2003 03:33 am, William Lee Irwin III wrote:
> On Wed, Sep 03, 2003 at 02:38:56AM +1000, Stuart Low wrote:
> > - -snip- -
> > nvidia: no version magic, tainting kernel.
> > nvidia: module license 'NVIDIA' taints kernel.
> > 0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4496
> > Wed Jul 16 19:03:09 PDT 2003
> > Debug: sleeping function called from invalid context at mm/slab.c:1817
>
> Looks very much like an nvidia problem; best to report it to them.
>
>
> -- wli

