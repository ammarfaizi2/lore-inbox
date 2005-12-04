Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbVLDPXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbVLDPXm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 10:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbVLDPXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 10:23:42 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:35007 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932250AbVLDPXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 10:23:41 -0500
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
From: Arjan van de Ven <arjan@infradead.org>
To: Richard Knutsson <ricknu-0@student.ltu.se>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <43930A5F.9050802@student.ltu.se>
References: <1133620598.22170.14.camel@laptopd505.fenrus.org>
	 <20051203152339.GK31395@stusta.de>
	 <20051203162755.GA31405@merlin.emma.line.org>
	 <1133630556.22170.26.camel@laptopd505.fenrus.org>
	 <20051203230520.GJ25722@merlin.emma.line.org>
	 <43923DD9.8020301@wolfmountaingroup.com>
	 <20051204121209.GC15577@merlin.emma.line.org>
	 <1133699555.5188.29.camel@laptopd505.fenrus.org>
	 <20051204132813.GA4769@merlin.emma.line.org>
	 <1133703338.5188.38.camel@laptopd505.fenrus.org>
	 <20051204142551.GB4769@merlin.emma.line.org>
	 <43930A5F.9050802@student.ltu.se>
Content-Type: text/plain
Date: Sun, 04 Dec 2005 16:23:35 +0100
Message-Id: <1133709816.5188.57.camel@laptopd505.fenrus.org>
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


> But I do wonder how copyright and GPL can co-exist. Do the copyright 
> holder own the changes anybody else does to the code?
> Anyone care to explain?

The GPL *is* copyright. You and I as copyright holders reserve all
rights, and then grant selected rights; the rights and the conditions
they are granted under are described in the COPYING file. It's a
misunderstanding to think that GPL means "no copyright" or "can do
anything I want"; in a way the GPL is quite a restrictive license.
(while it allows you to distribute, copy and make derived works, it only
does allow that under the condition that the result is made available
under the GPL as well in full source form, and there's some additional
conditions as well)

so GPL can copyright are not in conflict, the GPL can exist BECAUSE of
copyright actually.


