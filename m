Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbUJWOvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbUJWOvQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 10:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbUJWOr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 10:47:56 -0400
Received: from canuck.infradead.org ([205.233.218.70]:46606 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261209AbUJWOrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 10:47:00 -0400
Subject: Re: [PATCH} Trivial - fix drm_agp symbol export
From: Arjan van de Ven <arjan@infradead.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
       Dave Airlie <airlied@linux.ie>
In-Reply-To: <9e473391041023073578b11eb6@mail.gmail.com>
References: <9e473391041022214570eab48a@mail.gmail.com>
	 <20041023095644.GC30137@infradead.org>
	 <9e473391041023073578b11eb6@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1098542801.7207.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Sat, 23 Oct 2004 16:46:41 +0200
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.6 (++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (2.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[62.195.31.207 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[62.195.31.207 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-23 at 10:35 -0400, Jon Smirl wrote:
> How do I deal with something like a Red Hat kernel where CONFIG_AGP is
> set but the kernel may be running on hardware without AGP present. 

Nowadays RH builds AGP into the kernel always ;)
-- 

