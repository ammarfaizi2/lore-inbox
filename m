Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317887AbSHUFl7>; Wed, 21 Aug 2002 01:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317888AbSHUFl7>; Wed, 21 Aug 2002 01:41:59 -0400
Received: from dp.samba.org ([66.70.73.150]:65255 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S317887AbSHUFl7>;
	Wed, 21 Aug 2002 01:41:59 -0400
Date: Wed, 21 Aug 2002 15:35:54 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Anders Gustafsson <andersg@0x63.nu>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       trivial@rustcorp.com.au
Subject: Re: [PATCH] Remove extraneous ptrace.h include in hermes.c
Message-ID: <20020821053554.GI18818@zax>
Mail-Followup-To: David Gibson <hermes@gibson.dropbear.id.au>,
	Anders Gustafsson <andersg@0x63.nu>, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com, trivial@rustcorp.com.au
References: <20020820142634.GB577@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020820142634.GB577@h55p111.delphi.afb.lu.se>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2002 at 04:26:34PM +0200, Anders Gustafsson wrote:
> Remove extraneous ptrace.h include in hermes.c

Applied locally.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
