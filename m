Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267660AbUIHOkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267660AbUIHOkd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 10:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269106AbUIHOec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 10:34:32 -0400
Received: from unthought.net ([212.97.129.88]:38850 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S267660AbUIHN0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 09:26:46 -0400
Date: Wed, 8 Sep 2004 15:26:41 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Major XFS problems...
Message-ID: <20040908132641.GA390@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	"Piszcz, Justin Michael" <justin.piszcz@mitretek.org>,
	linux-kernel@vger.kernel.org
References: <2E314DE03538984BA5634F12115B3A4E62EB0E@email1.mitretek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2E314DE03538984BA5634F12115B3A4E62EB0E@email1.mitretek.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 09:07:56AM -0400, Piszcz, Justin Michael wrote:
> This is a very well written+detailed bug report, have you tried writing
> the linux-xfs mailing list?

Thank you  :)

No, I did not write the XFS list - but maybe I should...

I purposedly wrote directly to LKML to get the attention of a "broader
audience".

For example, the lowmem OOM problem may not be fixable by the XFS
developers alone (I don't know), and I've heard whisperings about the
debug.c:106 problem being related to knfsd changes in the 2.6 series
(don't know how credible that is either).

So, I thought, maybe if more people were made aware of this, the right
people would have a chance of figuring this out   :)

-- 

 / jakob

