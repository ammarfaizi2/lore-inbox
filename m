Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWEVNEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWEVNEn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 09:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWEVNEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 09:04:43 -0400
Received: from gw03.mail.saunalahti.fi ([195.197.172.111]:20364 "EHLO
	gw03.mail.saunalahti.fi") by vger.kernel.org with ESMTP
	id S1750810AbWEVNEm (ORCPT <rfc822;<linux-kernel@vger.kernel.org>>);
	Mon, 22 May 2006 09:04:42 -0400
From: Jan Knutar <jk-lkml@sci.fi>
To: Christian Trefzer <ctrefzer@gmx.de>
Subject: Re: [IDEA] Poor man's UPS
Date: Mon, 22 May 2006 16:04:14 +0300
User-Agent: KMail/1.6.2
Cc: Pau Garcia i Quiles <pgquiles@elpauer.org>, linux-kernel@vger.kernel.org
References: <200605212131.47860.pgquiles@elpauer.org> <20060521224012.GB30855@hermes.uziel.local>
In-Reply-To: <20060521224012.GB30855@hermes.uziel.local>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200605221604.16043.jk-lkml@sci.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 May 2006 01:40, Christian Trefzer wrote:
>
> I think it would be cheaper ("costs" for your solutin in terms of
> required I/O power and hard disk space) to use two or more lead
> batteries which are charged and discharged in a round-robin fashion,
> controlled by some smart home-brew circuitry, and connect the beast to
> some control/monitoring software via RS-232 ; )
> 
> The logic should at least completely drain the battery before
> recharging,

I thought deep discharge cycles were unhealthy for lead batteries?
