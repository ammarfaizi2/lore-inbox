Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263512AbTIWT1W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 15:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbTIWT0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 15:26:33 -0400
Received: from pizda.ninka.net ([216.101.162.242]:40924 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263508AbTIWTZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 15:25:17 -0400
Date: Tue, 23 Sep 2003 12:11:16 -0700
From: "David S. Miller" <davem@redhat.com>
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, kevin.vanmaren@unisys.com,
       peter@chubb.wattle.id.au, bcrl@kvack.org, ak@suse.de, iod00d@hp.com,
       peterc@gelato.unsw.edu.au, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-Id: <20030923121116.3dc23a45.davem@redhat.com>
In-Reply-To: <16240.35724.423746.180371@napali.hpl.hp.com>
References: <BFF315B8E1D7F845B8FC1C28778693D70AFEC6@usslc-exch1.na.uis.unisys.com>
	<16240.35724.423746.180371@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Sep 2003 11:06:04 -0700
David Mosberger <davidm@napali.hpl.hp.com> wrote:

> So what's wrong with doign prctl --fpemul=silent in the init process?
> The flags are inherited across fork().

Great, can we get such a setting for the kernel bits too?
