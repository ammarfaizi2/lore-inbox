Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262797AbVAQNfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262797AbVAQNfx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 08:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262799AbVAQNfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 08:35:53 -0500
Received: from canuck.infradead.org ([205.233.218.70]:51217 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262797AbVAQNfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 08:35:46 -0500
Subject: Re: [PATCH] revert- sys_setaltroot
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk
In-Reply-To: <20041222030304.07bb036e.akpm@osdl.org>
References: <200410261928.i9QJS7h3011015@hera.kernel.org>
	 <1103710694.6111.127.camel@localhost.localdomain>
	 <20041222030304.07bb036e.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 17 Jan 2005 13:35:33 +0000
Message-Id: <1105968934.26551.347.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-22 at 03:03 -0800, Andrew Morton wrote:
> There were security problems and suggestions that a namespace-based
> approach would be better.   umm, have a random sprinkle of emails:

The security problems have been addressed, and the namespace-based
approach was never coherently explained. I can't see how such would
work. 

-- 
dwmw2

