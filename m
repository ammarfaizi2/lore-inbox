Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751689AbVLAOMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbVLAOMj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 09:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbVLAOMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 09:12:39 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:56230 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750830AbVLAOMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 09:12:38 -0500
Subject: RE: [PATCH] aic79xx should be able to ignore HostRAID enabled
	adapters
From: Arjan van de Ven <arjan@infradead.org>
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       "Darrick J. Wong" <djwong@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Luvella McFadden <luvella@us.ibm.com>, AJ Johnson <blujuice@us.ibm.com>,
       Kevin Stansell <kstansel@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Mauelshagen@redhat.com
In-Reply-To: <547AF3BD0F3F0B4CBDC379BAC7E4189F01E3E318@otce2k03.adaptec.com>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01E3E318@otce2k03.adaptec.com>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 15:12:34 +0100
Message-Id: <1133446354.2853.51.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> [ You are on record as not giving a fig for the users, what if I showed
> them as starving children in a third world nation, would that melt your
> heart? ;-} ]

adaptec could just release the source of the enhancement to linux (as
the GPL basically requires anyway :)

