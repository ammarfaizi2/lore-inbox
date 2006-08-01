Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751794AbWHAS73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbWHAS73 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 14:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbWHAS73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 14:59:29 -0400
Received: from cantor2.suse.de ([195.135.220.15]:5316 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751794AbWHAS72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 14:59:28 -0400
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>
Subject: Re: [PATCH 22/33] x86_64: Fix gdt table size in trampoline.S
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	<11544302413302-git-send-email-ebiederm@xmission.com>
From: Andi Kleen <ak@suse.de>
Date: 01 Aug 2006 20:59:12 +0200
In-Reply-To: <11544302413302-git-send-email-ebiederm@xmission.com>
Message-ID: <p73zmeo1dvj.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Makes sense, thanks. I queued the patch.

-Andi
