Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbVLaIga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbVLaIga (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 03:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbVLaIga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 03:36:30 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:25792 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751312AbVLaIg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 03:36:29 -0500
Subject: Re: [PATCH 10 of 20] ipath - core driver, part 3 of 4
From: Arjan van de Ven <arjan@infradead.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <1135986615.13318.82.camel@serpentine.pathscale.com>
References: <c37b118ef80698acc4eb.1135816289@eng-12.pathscale.com>
	 <Pine.LNX.4.64.0512301043290.3249@g5.osdl.org>
	 <1135986615.13318.82.camel@serpentine.pathscale.com>
Content-Type: text/plain
Date: Sat, 31 Dec 2005 09:36:24 +0100
Message-Id: <1136018184.2901.6.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-30 at 15:50 -0800, Bryan O'Sullivan wrote:
> On Fri, 2005-12-30 at 10:46 -0800, Linus Torvalds wrote:
> 
> > All your user page lookup/pinning code is terminally broken.
> 
> Yes, this has been pointed out by a few others.
> 
> > Crap like this must not be merged.
> 
> I'm already busy decrappifying it...

the point I think also was the fact that it exists is already wrong :)

makes it easier for you.. "rm" is a very powerful decrappify tool, as is
"block delete" in just about any editor ;)


