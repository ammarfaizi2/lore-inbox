Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030421AbWARU1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030421AbWARU1p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 15:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030420AbWARU1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 15:27:45 -0500
Received: from mx.pathscale.com ([64.160.42.68]:53976 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1030421AbWARU1o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 15:27:44 -0500
Subject: Re: [PATCH 2/5] [RFC] Infiniband: connection abstraction
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Stephen Hemminger <shemminger@osdl.org>, Sean Hefty <sean.hefty@intel.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <1137568107.3005.69.camel@laptopd505.fenrus.org>
References: <ORSMSX401FRaqbC8wSA0000003e@orsmsx401.amr.corp.intel.com>
	 <ORSMSX401FRaqbC8wSA00000040@orsmsx401.amr.corp.intel.com>
	 <20060117153838.3dc2cd2e@dxpl.pdx.osdl.net>
	 <1137568107.3005.69.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Wed, 18 Jan 2006 12:27:32 -0800
Message-Id: <1137616052.4757.85.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 08:08 +0100, Arjan van de Ven wrote:

> the dual license text needs a bit of clarification I suspect to make
> explicit that the "or BSD" part only applies when used entirely outside
> the linux kernel. (that already is the case, just it's not explicit.
> Making that explicit would be good).

One appropriate way to do that would be to mark all IB-related exported
symbols as EXPORT_SYMBOL_GPL.

	<b

