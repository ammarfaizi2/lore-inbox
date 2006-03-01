Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751880AbWCAUfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbWCAUfJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 15:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbWCAUfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 15:35:08 -0500
Received: from mx.pathscale.com ([64.160.42.68]:37092 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751880AbWCAUfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 15:35:06 -0500
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060301202634.GC4081@kvack.org>
References: <1140841250.2587.33.camel@localhost.localdomain>
	 <200603012027.55494.ak@suse.de>
	 <1141242206.2899.109.camel@localhost.localdomain>
	 <200603012049.32670.ak@suse.de>
	 <1141243508.2899.126.camel@localhost.localdomain>
	 <20060301202634.GC4081@kvack.org>
Content-Type: text/plain
Date: Wed, 01 Mar 2006 12:35:20 -0800
Message-Id: <1141245321.2899.141.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-01 at 15:26 -0500, Benjamin LaHaise wrote:

> Please rename the macro something like 
> flush_wc() and document it as such, at which point I remove my objection.

Thanks.  That's a useful suggestion; I don't want to give the thing a
misleading name.

	<b

-- 
Bryan O'Sullivan <bos@pathscale.com>

