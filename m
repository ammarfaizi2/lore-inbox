Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbVASOqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVASOqK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 09:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVASOpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 09:45:04 -0500
Received: from canuck.infradead.org ([205.233.218.70]:16401 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261737AbVASOov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 09:44:51 -0500
Subject: Re: [PATCH] revert- sys_setaltroot
From: David Woodhouse <dwmw2@infradead.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <1105969356.6304.100.camel@laptopd505.fenrus.org>
References: <200410261928.i9QJS7h3011015@hera.kernel.org>
	 <1103710694.6111.127.camel@localhost.localdomain>
	 <20041222030304.07bb036e.akpm@osdl.org>
	 <1105968934.26551.347.camel@hades.cambridge.redhat.com>
	 <1105969356.6304.100.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Wed, 19 Jan 2005 14:44:37 +0000
Message-Id: <1106145878.26551.524.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-17 at 14:42 +0100, Arjan van de Ven wrote:
> > The security problems have been addressed, and the namespace-based
> > approach was never coherently explained. I can't see how such would
> > work.
> 
> see viro's recent proposal for bindmounts and the like.

Is that likely to be usable any time soon?

-- 
dwmw2

