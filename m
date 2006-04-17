Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbWDQDjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWDQDjN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 23:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbWDQDjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 23:39:13 -0400
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:18632 "EHLO
	mail4.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1750995AbWDQDjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 23:39:13 -0400
Date: Sun, 16 Apr 2006 23:39:06 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@intercode.com.au>,
       "David S. Miller" <davem@davemloft.net>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Per Liden <per.liden@ericsson.com>, Jon Maloy <jon.maloy@ericsson.com>,
       Allan Stephens <allan.stephens@windriver.com>,
       tipc-discussion@lists.sourceforge.net,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [PATCH 2/5] Remove redundant NULL checks before [kv]free - in 
 net/
In-Reply-To: <200604170328.56646.jesper.juhl@gmail.com>
Message-ID: <Pine.LNX.4.64.0604162338480.11613@d.namei>
References: <200604170328.56646.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2006, Jesper Juhl wrote:

> Redundant NULL check before kfree removal
> from net/
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>


Acked-by: James Morris <jmorris@namei.org>



-- 
James Morris
<jmorris@namei.org>
