Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVCTCkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVCTCkP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 21:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVCTCkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 21:40:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:20139 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261385AbVCTCkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 21:40:11 -0500
Date: Sat, 19 Mar 2005 18:40:05 -0800
From: Richard Henderson <rth@redhat.com>
To: jgarzik@pobox.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] _raw_read_trylock for alpha
Message-ID: <20050320024005.GA11737@redhat.com>
References: <20050319203933.GD7404@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050319203933.GD7404@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 19, 2005 at 03:39:33PM -0500, Jeff Garzik wrote:
> Don't send this patch upstream until its been verified to actually work.

It certainly won't.  I'll gen up something soon.


r~
