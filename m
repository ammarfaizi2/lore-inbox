Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbWDSLQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWDSLQa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 07:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbWDSLQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 07:16:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:45967 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750859AbWDSLQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 07:16:29 -0400
Subject: [Fwd: Re: 3w-9xxx status in kernel]
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org, Martin Honermeyer <maze@strahlungsfrei.de>
Content-Type: text/plain
Date: Wed, 19 Apr 2006 13:16:27 +0200
Message-Id: <1145445387.3085.27.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-------- Forwarded Message --------
> From: Martin Honermeyer <maze@strahlungsfrei.de>
> To: linux-kernel@vger.kernel.org
> Subject: Re: 3w-9xxx status in kernel
> Date: Wed, 19 Apr 2006 13:02:42 +0200
> 
> Hi,
> 
> same problem over here. Why does the newest kernel contain an old version of
> the 3w-9xxx driver? 

because nobody bothered to submit it??

> 
> We are having performance problems using a 9550SX controller. Read
> throughput (measured with hdparm) 

hdparm is not a good measurement tool at all for performance.
At least use something like tiobench (tiobench.sf.net)

