Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbVHCJLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbVHCJLQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 05:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbVHCJLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 05:11:11 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:19917 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262163AbVHCJJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 05:09:57 -0400
Subject: Re: [PATCH 00/14] GFS
From: Arjan van de Ven <arjan@infradead.org>
To: Hans Reiser <reiser@namesys.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       David Teigland <teigland@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
In-Reply-To: <42F01712.2030105@namesys.com>
References: <20050802071828.GA11217@redhat.com>
	 <1122968724.3247.22.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0508021655580.4138@yvahk01.tjqt.qr>
	 <1122994972.3247.31.camel@laptopd505.fenrus.org>
	 <42F01712.2030105@namesys.com>
Content-Type: text/plain
Date: Wed, 03 Aug 2005 11:09:02 +0200
Message-Id: <1123060142.3363.8.camel@laptopd505.fenrus.org>
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


> I don't know anything about GFS, but expecting a filesystem author to
> use a journaling layer he does not want to is a bit arrogant.

good that I didn't expect that then.
I think it's fair enough to ask people if they can use it. If the answer
is "No because it doesn't fit our model <here>" then that's fine. If the
answer is "eh yeah we could" then I think it's entirely reasonable to
expect people to use common code as opposed to adding new code.


