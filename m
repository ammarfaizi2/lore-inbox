Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267511AbUJRVdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267511AbUJRVdz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 17:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267649AbUJRV34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 17:29:56 -0400
Received: from zero.aec.at ([193.170.194.10]:58384 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S267683AbUJRV3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 17:29:18 -0400
To: =?iso-8859-1?Q?Espen_Fjellv=E6r_Olsen?= <espenfjo@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1 amd64 Computer crashes on "Freeing unused kernel
 memory: 200k"
References: <2QMVB-2nB-13@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Mon, 18 Oct 2004 23:29:13 +0200
In-Reply-To: <2QMVB-2nB-13@gated-at.bofh.it> (Espen
 =?iso-8859-1?Q?Fjellv=E6r?= Olsen's message of "Mon, 18 Oct 2004 23:10:11 +0200")
Message-ID: <m3wtxn67h2.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Espen Fjellvær Olsen <espenfjo@gmail.com> writes:

> I recently got a new AMD64 3400+ computer, i'm installing gentoo from
> the gentoo-amd64-livecd.
> All goes well, until i try to boot my newly compiled kernel.
> I't stops at "Freeing unused kernel memory: 200k", no oopses or other
> information.
> I compiled it with gcc-3.3.4.

Does it work with an mainline kernel like 2.6.9rc4 or "2.6.9-final" ?

-Andi

