Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbWH1Ind@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWH1Ind (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 04:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWH1Ind
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 04:43:33 -0400
Received: from ns1.suse.de ([195.135.220.2]:49876 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751313AbWH1Inb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 04:43:31 -0400
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, henti@geekware.co.za
Subject: Re: linux on Intel D915GOM oops
References: <20060828102149.26b05e8b@yoda.foad.za.net>
	<1156754346.3034.167.camel@laptopd505.fenrus.org>
From: Andi Kleen <ak@suse.de>
Date: 28 Aug 2006 10:43:17 +0200
In-Reply-To: <1156754346.3034.167.camel@laptopd505.fenrus.org>
Message-ID: <p7364gddzdm.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:
> 
> this is the known bug where by default Linux uses the BIOS services for
> PCI rather than the native method.

It's a BIOS bug if the PCI BIOS doesn't work, not a Linux bug.

-Andi
