Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbWARHIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbWARHIg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 02:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWARHIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 02:08:36 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:1438 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964892AbWARHIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 02:08:35 -0500
Subject: Re: [PATCH 2/5] [RFC] Infiniband: connection abstraction
From: Arjan van de Ven <arjan@infradead.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Sean Hefty <sean.hefty@intel.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20060117153838.3dc2cd2e@dxpl.pdx.osdl.net>
References: <ORSMSX401FRaqbC8wSA0000003e@orsmsx401.amr.corp.intel.com>
	 <ORSMSX401FRaqbC8wSA00000040@orsmsx401.amr.corp.intel.com>
	 <20060117153838.3dc2cd2e@dxpl.pdx.osdl.net>
Content-Type: text/plain
Date: Wed, 18 Jan 2006 08:08:26 +0100
Message-Id: <1137568107.3005.69.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> <flamebait>
> Also should infiniband exports be EXPORT_SYMBOL_GPL, to make
> it clear that binary drivers for this are not allowed??
> </flamebait>

the dual license text needs a bit of clarification I suspect to make
explicit that the "or BSD" part only applies when used entirely outside
the linux kernel. (that already is the case, just it's not explicit.
Making that explicit would be good).



