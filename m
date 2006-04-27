Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030184AbWD0P3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030184AbWD0P3I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 11:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030187AbWD0P3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 11:29:08 -0400
Received: from zakalwe.fi ([80.83.5.154]:36104 "EHLO zakalwe.fi")
	by vger.kernel.org with ESMTP id S1030184AbWD0P3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 11:29:07 -0400
Date: Thu, 27 Apr 2006 15:29:05 +0000
From: Heikki Orsila <shd@zakalwe.fi>
To: Heiko J Schick <schihei@de.ibm.com>
Cc: openib-general@openib.org, Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 02/16] ehca: module infrastructure
Message-ID: <20060427152905.GB14413@zakalwe.fi>
References: <4450A165.4000701@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <4450A165.4000701@de.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2006 at 12:48:05PM +0200, Heiko J Schick wrote:
> + *  This source code is distributed under a dual license of GPL v2.0 and 
> OpenIB
> + *  BSD.
> + *
> + * OpenIB BSD License
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions are 
> met:
> + *
> + * Redistributions of source code must retain the above copyright notice, 
> this
> + * list of conditions and the following disclaimer.
> + *
> + * Redistributions in binary form must reproduce the above copyright 
> notice,
> + * this list of conditions and the following disclaimer in the 
> documentation
> + * and/or other materials
> + * provided with the distribution.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS 
> IS"
> + * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, 
> THE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR 
> PURPOSE
> + * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
> + * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> + * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
> + * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
> + * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
> WHETHER
> + * IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR 
> OTHERWISE)
> + * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF 
> THE
> + * POSSIBILITY OF SUCH DAMAGE.

Would you please keep the full license in only one file? It seems to be
duplicated in all source modules. It's wasty.

> + *  $Id: ehca_main.c,v 1.35 2006/04/25 08:59:43 schickhj Exp $

This shouldn't be here. The kernel project has its own versioning.

-- 
Heikki Orsila                   Barbie's law:
heikki.orsila@iki.fi            "Math is hard, let's go shopping!"
http://www.iki.fi/shd
