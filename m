Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265088AbSKESxR>; Tue, 5 Nov 2002 13:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265089AbSKESxR>; Tue, 5 Nov 2002 13:53:17 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:13984 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265088AbSKESxL>;
	Tue, 5 Nov 2002 13:53:11 -0500
Date: Tue, 5 Nov 2002 19:59:30 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjanv@redhat.com>,
       Jeff Garzik <jgarzik@pobox.com>, zippel@linux-m68k.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: zippel@linux-m68k.org
Subject: Re: [PATCH] Allow 'n' as a symbol value in the .config file.
Message-ID: <20021105185930.GB1137@suse.de>
References: <20021105165024.GJ13587@suse.de> <3DC7FB11.10209@pobox.com> <20021105171409.GA1137@suse.de> <1036517201.5601.0.camel@localhost.localdomain> <20021105172617.GC1830@suse.de> <1036520436.4791.114.camel@irongate.swansea.linux.org.uk> <20021105185511.GR2502@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021105185511.GR2502@pasky.ji.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05 2002, Petr Baudis wrote:
>   Hello,
> 
>   this patch (against 2.5.46) enabled recognition of 'n' tristate/boolean
> symbol value in the .config file. This allows more convenient manual
> editing of the .config file. Please apply.

Indeed, thank you very much! Confirmed to work here. Roman, can you pass
on this change?

-- 
Jens Axboe

