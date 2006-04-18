Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWDRVwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWDRVwG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 17:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWDRVwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 17:52:05 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:63670
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750718AbWDRVwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 17:52:04 -0400
Date: Tue, 18 Apr 2006 14:51:53 -0700 (PDT)
Message-Id: <20060418.145153.00623896.davem@davemloft.net>
To: jmorris@namei.org
Cc: jesper.juhl@gmail.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       jmorris@intercode.com.au, kuznet@ms2.inr.ac.ru, per.liden@ericsson.com,
       jon.maloy@ericsson.com, allan.stephens@windriver.com,
       tipc-discussion@lists.sourceforge.net, jengelh@linux01.gwdg.de
Subject: Re: [PATCH 2/5] Remove redundant NULL checks before [kv]free - in
 net/
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0604162338480.11613@d.namei>
References: <200604170328.56646.jesper.juhl@gmail.com>
	<Pine.LNX.4.64.0604162338480.11613@d.namei>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morris <jmorris@namei.org>
Date: Sun, 16 Apr 2006 23:39:06 -0400 (EDT)

> On Mon, 17 Apr 2006, Jesper Juhl wrote:
> 
> > Redundant NULL check before kfree removal
> > from net/
> > 
> > Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> 
> 
> Acked-by: James Morris <jmorris@namei.org>

Applied, thanks Jesper.
