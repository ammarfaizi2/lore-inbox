Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264825AbTFLLNT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 07:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264826AbTFLLNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 07:13:19 -0400
Received: from ns.suse.de ([213.95.15.193]:12806 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264825AbTFLLNR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 07:13:17 -0400
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: open(.. O_DIRECT ..) difference in between Linux and FreeBSD ..
References: <20030612111437.GE28900@mea-ext.zmailer.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 12 Jun 2003 13:26:54 +0200
In-Reply-To: <20030612111437.GE28900@mea-ext.zmailer.org.suse.lists.linux.kernel>
Message-ID: <p731xxz5yf5.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio <matti.aarnio@zmailer.org> writes:

> Unlike Linux, FreeBSD (where this flag originates, apparently) does

It doesn't. It originates from Irix. AFAIK Irix has similar restrictions.

-Andi
