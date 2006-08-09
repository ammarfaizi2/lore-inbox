Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbWHIOtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbWHIOtG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 10:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbWHIOtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 10:49:06 -0400
Received: from mserv3.uoregon.edu ([128.223.142.101]:60612 "EHLO
	smtp.uoregon.edu") by vger.kernel.org with ESMTP id S1750918AbWHIOtF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 10:49:05 -0400
Date: Wed, 9 Aug 2006 07:48:15 -0700
From: Joel Jaeggli <joelja@uoregon.edu>
To: "gmu 2k6" <gmu2006@gmail.com>
Cc: davids@webmaster.com, "Thomas Stewart" <thomas@stewarts.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Only 3.2G ram out of 4G seen in an i386 box
Message-Id: <20060809074815.bec7f32c.joelja@uoregon.edu>
In-Reply-To: <f96157c40608082351j301efa57n412284f8d28124ef@mail.gmail.com>
References: <20060808101504.GJ2152@stingr.net>
	<MDEHLPKNGKAHNMBLJOLKKEDCNKAB.davids@webmaster.com>
	<f96157c40608082351j301efa57n412284f8d28124ef@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2006 08:51:41 +0200
"gmu 2k6" <gmu2006@gmail.com> wrote:

> >        Are these technical notes supposed to be so funny?
> >
> >        DS
> 
> I guess this is all related to older Intel chipsets, right? I mean the
> chipset *75X something I'm going to have in the new box I will get
> soonish will support up to 8 GiB. I hope it does not mean that it will
> be capped at 7.4GiB although I will only have 4GiB installed for now.

most modern 64 bit x86 systems will relocate this memory hole to somewhere else within the address space (memory hoisting)... You'll probably find the it reappers the first time you buy a system with 1TB of ram...  

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
