Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751494AbWGaFZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbWGaFZg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 01:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbWGaFZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 01:25:35 -0400
Received: from colin.muc.de ([193.149.48.1]:45839 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751494AbWGaFZe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 01:25:34 -0400
Date: 31 Jul 2006 07:25:33 +0200
Date: Mon, 31 Jul 2006 07:25:33 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Reuben Farrelly <reuben-lkml@reub.net>, linux-kernel@vger.kernel.org,
       jbeulich@novell.com
Subject: Re: 2.6.18-rc2-mm1
Message-ID: <20060731052533.GA14134@muc.de>
References: <20060727015639.9c89db57.akpm@osdl.org> <44CD8A34.5030305@reub.net> <20060730215739.f8a31429.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060730215739.f8a31429.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, thanks.  But the "DWARF2 unwinder stuck" problem remains.

It will be a long time until it is all solved correctly, because it 
requires adding correct CFI to a code a lot all over.  I estimate it will need
several major releases at least.

-Andi

> 
