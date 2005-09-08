Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbVIHQMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbVIHQMY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 12:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbVIHQMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 12:12:23 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:58025 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964888AbVIHQMX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 12:12:23 -0400
Subject: Re: [PATCH] add stricmp
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan Beulich <JBeulich@novell.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <432078D102000078000244D5@emea1-mh.id2.novell.com>
References: <43206F420200007800024455@emea1-mh.id2.novell.com>
	 <20050908151754.GB11067@infradead.org>
	 <432074B302000078000244A3@emea1-mh.id2.novell.com>
	 <1126195489.19834.39.camel@localhost.localdomain>
	 <432078D102000078000244D5@emea1-mh.id2.novell.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 08 Sep 2005 17:37:13 +0100
Message-Id: <1126197433.19834.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-09-08 at 17:45 +0200, Jan Beulich wrote:
> >The only general, usable strnicmp safe for general kernel use would be
> a
> >full all singing all dancing UTF-8 symbol aware arbitary locale
> >implementation. And that we *definitely* do not want in kernel.
> 
> Then you'd want to immediately get rid of the mentioned, pre-exisiting
> strnicmp().

Yes

