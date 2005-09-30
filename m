Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932552AbVI3RyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbVI3RyR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 13:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbVI3RyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 13:54:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:44239 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932552AbVI3RyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 13:54:16 -0400
Subject: RE: I request inclusion of SAS Transport Layer and AIC-94xx into
	the kernel
From: Arjan van de Ven <arjan@infradead.org>
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Cc: "Tuikov, Luben" <Luben_Tuikov@adaptec.com>, andrew.patterson@hp.com,
       dougg@torque.net, Linus Torvalds <torvalds@osdl.org>,
       Luben Tuikov <ltuikov@yahoo.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <547AF3BD0F3F0B4CBDC379BAC7E4189F01A9FA11@otce2k03.adaptec.com>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01A9FA11@otce2k03.adaptec.com>
Content-Type: text/plain
Date: Fri, 30 Sep 2005 19:53:57 +0200
Message-Id: <1128102837.3012.15.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
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

On Fri, 2005-09-30 at 13:07 -0400, Salyzyn, Mark wrote:
> At the SAS BOF, I indicated that it would not be much trouble to
> translate the CSMI handler in the aacraid driver to a similar sysfs
> arrangement. If such info can be mined from a firmware based RAID card,
> every driver should be able to do so. The spec writers really need to
> consider rewriting SDI for sysfs (if they have not already) and move
> away from an ABI.

that makes me wonder... why and how does T10 control linux abi's ??


