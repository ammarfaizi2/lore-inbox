Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbVLLT2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbVLLT2N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 14:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbVLLT2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 14:28:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27096 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932165AbVLLT2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 14:28:12 -0500
Date: Mon, 12 Dec 2005 11:27:46 -0800
From: Richard Henderson <rth@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ashutosh Naik <ashutosh.naik@gmail.com>, anandhkrishnan@yahoo.com,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, greg@kroah.com
Subject: Re: [RFC][PATCH] Prevent overriding of Symbols in the Kernel, avoiding Undefined behaviour
Message-ID: <20051212192746.GE19245@redhat.com>
References: <81083a450512120439h69ccf938m12301985458ea69f@mail.gmail.com> <20051212111322.40be4cfe.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051212111322.40be4cfe.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2005 at 11:13:22AM -0800, Andrew Morton wrote:
> Do we really need to do this at runtime?

Probably.  One could consider this a security hole...


r~
