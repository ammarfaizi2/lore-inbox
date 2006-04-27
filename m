Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965119AbWD0Mlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965119AbWD0Mlr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 08:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965123AbWD0Mlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 08:41:47 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:3820 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S965119AbWD0Mlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 08:41:46 -0400
Date: Thu, 27 Apr 2006 14:41:44 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Heiko J Schick <schihei@de.ibm.com>
Cc: openib-general@openib.org, Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 14/16] ehca: hardware interface
Message-ID: <20060427124144.GI32127@wohnheim.fh-wedel.de>
References: <4450A1C8.7090407@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4450A1C8.7090407@de.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 April 2006 12:49:44 +0200, Heiko J Schick wrote:
> +#ifndef EHCA_USE_HCALL
> +#include "sim_gal.h"
> +#endif

Again, somethin's fishy.  And in this case, your own code seems to
be. ;)

Jörn

-- 
Simplicity is prerequisite for reliability.
-- Edsger W. Dijkstra
