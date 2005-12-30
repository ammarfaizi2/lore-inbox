Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964962AbVL3XuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbVL3XuT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 18:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbVL3XuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 18:50:19 -0500
Received: from mx.pathscale.com ([64.160.42.68]:56477 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S964970AbVL3XuP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 18:50:15 -0500
Subject: Re: [PATCH 10 of 20] ipath - core driver, part 3 of 4
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <Pine.LNX.4.64.0512301043290.3249@g5.osdl.org>
References: <c37b118ef80698acc4eb.1135816289@eng-12.pathscale.com>
	 <Pine.LNX.4.64.0512301043290.3249@g5.osdl.org>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Fri, 30 Dec 2005 15:50:15 -0800
Message-Id: <1135986615.13318.82.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-30 at 10:46 -0800, Linus Torvalds wrote:

> All your user page lookup/pinning code is terminally broken.

Yes, this has been pointed out by a few others.

> Crap like this must not be merged.

I'm already busy decrappifying it...

	<b

