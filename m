Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVHDTxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVHDTxo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 15:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262640AbVHDTxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 15:53:43 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:28093 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261391AbVHDTwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 15:52:34 -0400
Subject: Re: [RFC] Move InfiniBand .h files
From: Arjan van de Ven <arjan@infradead.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
In-Reply-To: <52wtn18r7w.fsf@cisco.com>
References: <52iryla9r5.fsf@cisco.com>
	 <1123178038.3318.40.camel@laptopd505.fenrus.org> <52acjxa70j.fsf@cisco.com>
	 <1123180717.3318.43.camel@laptopd505.fenrus.org> <52wtn18r7w.fsf@cisco.com>
Content-Type: text/plain
Date: Thu, 04 Aug 2005 21:51:34 +0200
Message-Id: <1123185094.3318.51.camel@laptopd505.fenrus.org>
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

On Thu, 2005-08-04 at 11:57 -0700, Roland Dreier wrote:
>     Roland> Also, drivers/infiniband/include doesn't get put into the
>     Roland> /lib/modules/<ver>/build directory,
> 
>     Arjan> that is a symlink not a directory, and a symlink to the
>     Arjan> full source...
> 
> Sorry, I was too terse about the problem.  You're right, but typical
> distros don't ship full kernel source in their "support kernel builds"
> package.

so what makes you think they will ship include/infiniband ?


