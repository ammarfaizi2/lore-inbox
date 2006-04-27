Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965053AbWD0Nrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbWD0Nrh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 09:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbWD0Nrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 09:47:37 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:35210 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S965053AbWD0Nrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 09:47:36 -0400
Date: Thu, 27 Apr 2006 15:47:03 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Heiko J Schick <schihei@de.ibm.com>, openib-general@openib.org,
       Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 13/16] ehca: firmware InfiniBand interface
Message-ID: <20060427134703.GL32127@wohnheim.fh-wedel.de>
References: <4450A1C0.3080209@de.ibm.com> <20060427123701.GG32127@wohnheim.fh-wedel.de> <84144f020604270642j788be2ecp82841ac3b3ebcaad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84144f020604270642j788be2ecp82841ac3b3ebcaad@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 April 2006 16:42:52 +0300, Pekka Enberg wrote:
> On 4/27/06, Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
> > The whole patch is full of parameter-happy functions with this one
> > being the ugly top of the iceberg.  I sincerely hope this is not a
> > defined ABI and can still be changed.
> 
> It's not in mainline, so it can be changed.

I was thinking more about firmware ABI.

Jörn

-- 
But this is not to say that the main benefit of Linux and other GPL
software is lower-cost. Control is the main benefit--cost is secondary.
-- Bruce Perens
