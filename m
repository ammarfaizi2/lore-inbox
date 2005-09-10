Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbVIJKLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbVIJKLk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 06:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbVIJKLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 06:11:40 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:2960 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750736AbVIJKLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 06:11:39 -0400
Subject: Re: GFS, what's remaining
From: Arjan van de Ven <arjan@infradead.org>
To: David Teigland <teigland@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-cluster@redhat.com
In-Reply-To: <20050905054348.GC11337@redhat.com>
References: <20050901104620.GA22482@redhat.com>
	 <1125574523.5025.10.camel@laptopd505.fenrus.org>
	 <20050905054348.GC11337@redhat.com>
Content-Type: text/plain
Date: Sat, 10 Sep 2005 12:11:29 +0200
Message-Id: <1126347089.3222.138.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> You removed the comment stating exactly why, see below.  If that's not a
> accepted technique in the kernel, say so and I'll be happy to change it
> here and elsewhere.
> Thanks,
> Dave

entirely useless wrapping is not acceptable indeed.


