Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265580AbTFRWb1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 18:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265581AbTFRWb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 18:31:26 -0400
Received: from ns.suse.de ([213.95.15.193]:35849 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265580AbTFRWbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 18:31:21 -0400
Date: Thu, 19 Jun 2003 00:45:16 +0200
From: Andi Kleen <ak@suse.de>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [2.5.72] Oops on x86_64 running 32-bit code
Message-ID: <20030618224516.GF3543@wotan.suse.de>
References: <1055976017.25153.74.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055976017.25153.74.camel@serpentine.internal.keyresearch.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 03:40:17PM -0700, Bryan O'Sullivan wrote:
> Call Trace:<ffffffff80113b38>??default_do_nmi+56?? <ffffffff8011c787>??do_nmi+87??
>        <ffffffff801126dc>??nmi+112?? <ffffffff801320f2>??load_balance+34??

Looks quite garbled. Is it reproducible?

-Andi
