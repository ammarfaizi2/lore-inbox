Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbWC3Vyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWC3Vyg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 16:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbWC3Vyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 16:54:35 -0500
Received: from mx.pathscale.com ([64.160.42.68]:14274 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751006AbWC3Vyf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 16:54:35 -0500
Subject: Re: [PATCH 0 of 16] ipath - driver submission for 2.6.17
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <adairpv1wey.fsf@cisco.com>
References: <patchbomb.1143674603@chalcedony.internal.keyresearch.com>
	 <adairpv1wey.fsf@cisco.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Thu, 30 Mar 2006 13:54:34 -0800
Message-Id: <1143755674.24402.9.camel@chalcedony.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-30 at 12:59 -0800, Roland Dreier wrote:

> Should I just make IPATH_CORE depend on NET as well?

Yes, please.  I actually did that myself, but must have fumbled
something in quilt before I sent you the patches.

	<b

