Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030238AbVIAQlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbVIAQlX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 12:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbVIAQlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 12:41:23 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:57543 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1030235AbVIAQlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 12:41:22 -0400
Date: Thu, 1 Sep 2005 18:41:12 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: David Teigland <teigland@redhat.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/14] GFS: headers
Message-ID: <20050901164112.GB4226@wohnheim.fh-wedel.de>
References: <20050901135442.GA25581@redhat.com> <1125584374.5025.18.camel@laptopd505.fenrus.org> <20050901145948.GS25581@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050901145948.GS25581@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 September 2005 22:59:48 +0800, David Teigland wrote:
> 
> We offered to removed this when I explained it before.  It sounds like it
> would give you some comfort so I'll just go ahead and do it barring any
> pleas otherwise.

Please do.  Just have one test machine with an endianness different
from the on-disk format.

Having the on-disk format always be big-endian would serve this
purpose quite well, btw.  But buying an (before-intel) apple machine
also would.

Jörn

-- 
More computing sins are committed in the name of efficiency (without
necessarily achieving it) than for any other single reason - including
blind stupidity.
-- W. A. Wulf 
