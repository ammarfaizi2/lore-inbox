Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265076AbTIDOdm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 10:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265059AbTIDOc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 10:32:27 -0400
Received: from chaos.analogic.com ([204.178.40.224]:61312 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265043AbTIDOb6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 10:31:58 -0400
Date: Thu, 4 Sep 2003 10:33:56 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Sean Neakums <sneakums@zork.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: nasm over gas?
In-Reply-To: <6uiso8r5wl.fsf@zork.zork.net>
Message-ID: <Pine.LNX.4.53.0309041030000.3497@chaos>
References: <20030904104245.GA1823@leto2.endorphin.org> <3F5741BD.5000401@mbda.fr>
 <Pine.LNX.4.53.0309041001090.3367@chaos> <6uiso8r5wl.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003, Sean Neakums wrote:

> "Richard B. Johnson" <root@chaos.analogic.com> writes:
>
> > If you decide to use gcc as a preprocessor, you can't use comments,
> > NotGood(tm) because the "#" and some stuff after it gets "interpreted"
> > by cpp.
>
> Although one could use C-style comments in this scenario, yes?
>

Sure. Then it's not assembly. It's some polymorphic conglomeration
of crap ......... don't get me started.  If you write in assembler,
please learn to use the assembler. Assembly is not 'C'.

Use the right tool for the right thing. Both are tools, the fact
that you can shovel with an axe does not make the axe a shovel.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


