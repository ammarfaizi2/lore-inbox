Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290289AbSFNS01>; Fri, 14 Jun 2002 14:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311898AbSFNS00>; Fri, 14 Jun 2002 14:26:26 -0400
Received: from ns.suse.de ([213.95.15.193]:23813 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S290289AbSFNS0Z>;
	Fri, 14 Jun 2002 14:26:25 -0400
Date: Fri, 14 Jun 2002 20:26:19 +0200
From: Andi Kleen <ak@suse.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: ralf@gnu.org, engebret@us.ibm.com, schwidefsky@de.ibm.com,
        linux390@de.ibm.com, davem@redhat.com, ak@suse.de, davidm@hpl.hp.com,
        anton@samba.org, paulus@samba.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Take 2: Consolidate sys32_utime
Message-ID: <20020614202619.A11896@wotan.suse.de>
In-Reply-To: <20020614175319.3ea434ff.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andi:  I have also removed ia32_utime as I couldn't find it used
> anywhere.

Thanks. It's indeed redundant.

-Andi
