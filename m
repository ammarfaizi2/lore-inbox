Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbTICJOg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 05:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbTICJOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 05:14:36 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:48267 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261692AbTICJOf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 05:14:35 -0400
Date: Wed, 3 Sep 2003 10:13:56 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kars de Jong <jongk@linux-m68k.org>,
       Linux/m68k kernel mailing list 
	<linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030903091356.GA20528@mail.jlokier.co.uk>
References: <1062535375.3501.11.camel@kars.perseus.home> <Pine.GSO.4.21.0309030958130.6985-100000@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0309030958130.6985-100000@waterleaf.sonytel.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:
> So the store buffer is coherent on 68020 with external MMU, while it
> isn't on 68040 with internal MMU...

Does the 68020 even _have_ the equivalent of a store buffer?

-- Jamie
