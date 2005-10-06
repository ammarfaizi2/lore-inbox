Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751031AbVJFOLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbVJFOLW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 10:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbVJFOLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 10:11:22 -0400
Received: from ns.suse.de ([195.135.220.2]:18083 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751024AbVJFOLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 10:11:21 -0400
Date: Thu, 6 Oct 2005 16:11:19 +0200
From: Andi Kleen <ak@suse.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, Kirill Korotaev <dev@sw.ru>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, xemul@sw.ru,
       Andrey Savochkin <saw@sawoct.com>, st@sw.ru
Subject: Re: [discuss] Re: SMP syncronization on AMD processors (broken?)
Message-ID: <20051006141119.GE6642@verdi.suse.de>
References: <434520FF.8050100@sw.ru> <p73hdbuzs7l.fsf@verdi.suse.de> <43452BAC.3000306@cosmosbay.com> <200510061556.31305.ak@suse.de> <43453042.4030400@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43453042.4030400@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry Andi, I only trust assembly :)

Ok the datatype is int, but the assembly still uses decb. Will change that
to a decl.

-Andi
