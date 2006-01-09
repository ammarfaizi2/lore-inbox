Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWAIV1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWAIV1W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 16:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWAIV1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 16:27:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:7891 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750717AbWAIV1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 16:27:21 -0500
Subject: Re: Is Sony violating Linux GPL?
From: Arjan van de Ven <arjan@infradead.org>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: Salvador Fandino <sfandino@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1136815034.1043.42.camel@grayson>
References: <dpto0m$ck3$1@sea.gmane.org>  <1136815034.1043.42.camel@grayson>
Content-Type: text/plain
Date: Mon, 09 Jan 2006 22:27:12 +0100
Message-Id: <1136842032.2936.32.camel@laptopd505.fenrus.org>
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

On Mon, 2006-01-09 at 08:57 -0500, Ben Collins wrote:
> On Mon, 2006-01-09 at 14:22 +0100, Salvador Fandino wrote:
> > Then I started mailing Vaio technical support (support@vaio-link.com),
> > asking for the drivers source code, and after several mails they just
> > refused to give me the drivers source code because "These drivers are
> > directly delivered to us by the manufacturers of the hardware and
> > modified by us and therefore we are not obliged to supply any source
> > code for these drivers".
> > 
> > I am not an expert on Linux internals but I doubt a driver for this kind
> > of device could be developed independently enough of the kernel to not
> > be considered a derived work, so is Sony violating the Linux license?
> 
> They are correct. The deal with modules is they don't have to GPL them.

there is no such agreement or deal. There is no exception to the GPL in
this regard at all (but yes that's a semi common misconception/excuse
used by binary driver people)

