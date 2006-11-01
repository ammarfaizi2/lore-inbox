Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946951AbWKAR2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946951AbWKAR2T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 12:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946952AbWKAR2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 12:28:19 -0500
Received: from ns.suse.de ([195.135.220.2]:52895 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1946951AbWKAR2T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 12:28:19 -0500
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 1/7] paravirtualization: header and stubs for paravirtualizing critical operations
Date: Wed, 1 Nov 2006 18:27:48 +0100
User-Agent: KMail/1.9.5
Cc: Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.osdl.org,
       Chris Wright <chrisw@sous-sol.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <20061029024504.760769000@sous-sol.org> <1162376827.23462.5.camel@localhost.localdomain> <1162377928.23744.4.camel@laptopd505.fenrus.org>
In-Reply-To: <1162377928.23744.4.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611011827.49108.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 November 2006 11:45, Arjan van de Ven wrote:

> this is a lot of infrastructure... do we have more than 1 user of this
> yet that wants to get merged in mainline?

AFAIK xen, vmi, lhype (and native ops).

-Andi
