Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261453AbTC0WTT>; Thu, 27 Mar 2003 17:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261454AbTC0WTS>; Thu, 27 Mar 2003 17:19:18 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:54286 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261453AbTC0WTQ>; Thu, 27 Mar 2003 17:19:16 -0500
Date: Thu, 27 Mar 2003 22:30:29 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] d_alloc_anon for 2.4.21-pre6
Message-ID: <20030327223029.A7055@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"J.A. Magallon" <jamagallon@able.es>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53L.0303262107480.2544@freak.distro.conectiva> <20030327165112.A2395@infradead.org> <20030327222559.GA3420@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030327222559.GA3420@werewolf.able.es>; from jamagallon@able.es on Thu, Mar 27, 2003 at 11:25:59PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 27, 2003 at 11:25:59PM +0100, J.A. Magallon wrote:
> The patch I had from time ago in -jam also included this switch to
> list_for_each:

Yes, that's also a nice cleanup, but less important then d_alloc_anon.

