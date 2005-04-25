Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVDYX3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVDYX3Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 19:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVDYX3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 19:29:16 -0400
Received: from fire.osdl.org ([65.172.181.4]:53722 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261232AbVDYX3M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 19:29:12 -0400
Date: Mon, 25 Apr 2005 16:27:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: roland@topspin.com, hch@infradead.org, hozer@hozed.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-Id: <20050425162740.702a171b.akpm@osdl.org>
In-Reply-To: <426D7B8F.6000903@ammasso.com>
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>
	<20050411142213.GC26127@kalmia.hozed.org>
	<52mzs51g5g.fsf@topspin.com>
	<20050411163342.GE26127@kalmia.hozed.org>
	<5264yt1cbu.fsf@topspin.com>
	<20050411180107.GF26127@kalmia.hozed.org>
	<52oeclyyw3.fsf@topspin.com>
	<20050411171347.7e05859f.akpm@osdl.org>
	<4263DEC5.5080909@ammasso.com>
	<20050418164316.GA27697@infradead.org>
	<4263E445.8000605@ammasso.com>
	<20050423194421.4f0d6612.akpm@osdl.org>
	<426BABF4.3050205@ammasso.com>
	<52is2bvvz5.fsf@topspin.com>
	<20050425135401.65376ce0.akpm@osdl.org>
	<521x8yv9vb.fsf@topspin.com>
	<20050425151459.1f5fb378.akpm@osdl.org>
	<426D6DFA.4090908@ammasso.com>
	<20050425153542.70197e6a.akpm@osdl.org>
	<426D725C.4070103@ammasso.com>
	<20050425161330.32c32b4b.akpm@osdl.org>
	<426D7B8F.6000903@ammasso.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi <timur.tabi@ammasso.com> wrote:
>
> FYI, our driver detects the process termination and cleans up everything itself.

How is this implemented?
