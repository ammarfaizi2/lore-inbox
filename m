Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266289AbUHJOBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266289AbUHJOBM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 10:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266275AbUHJOA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 10:00:29 -0400
Received: from digitalimplant.org ([64.62.235.95]:44257 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S266183AbUHJN7L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 09:59:11 -0400
Date: Tue, 10 Aug 2004 06:58:38 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Nigel Cunningham <ncunningham@linuxmail.org>
cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "" <david-b@pacbell.net>
Subject: Re: [RFC] Fix Device Power Management States
In-Reply-To: <1092130981.2676.1.camel@laptop.cunninghams>
Message-ID: <Pine.LNX.4.50.0408100655190.13807-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net> 
 <20040809113829.GB9793@elf.ucw.cz>  <Pine.LNX.4.50.0408090840560.16137-100000@monsoon.he.net>
  <20040809212949.GA1120@elf.ucw.cz>  <Pine.LNX.4.50.0408092156480.24154-100000@monsoon.he.net>
 <1092130981.2676.1.camel@laptop.cunninghams>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Aug 2004, Nigel Cunningham wrote:

> Do you want me to merge before or after all this is done; I'm a bit
> concerned that you guys are expending effort (well, Pavel is), getting
> SMP and Highmem going when I already have a working version that -
> unless the plans have changed - we were intending to merge too.

It would be nice if you posted small easily-consumable patches that
gradually merged the two. Even if you post them all at once, it provides
something to review and an understanding of how one evolves into the
other.


	Pat
