Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264362AbTFQHNC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 03:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264375AbTFQHNC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 03:13:02 -0400
Received: from ns.suse.de ([213.95.15.193]:52238 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264362AbTFQHNB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 03:13:01 -0400
To: Michal Jaegermann <michal@harddata.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [x86_64] soft power-off question
References: <20030616165028.A3222@mail.harddata.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 17 Jun 2003 09:26:53 +0200
In-Reply-To: <20030616165028.A3222@mail.harddata.com.suse.lists.linux.kernel>
Message-ID: <p738ys1411e.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Jaegermann <michal@harddata.com> writes:

> Is it possible to turn off power on a dual processor x86_64 board with
> 'halt -p' or similar?  If yes then what is needed on a kernel level?

You need ACPI.

> I know that this does not work with "distribution" kernels.

It works fine with SuSE kernels.

-Andi
