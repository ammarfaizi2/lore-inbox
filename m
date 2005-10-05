Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965141AbVJEMHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965141AbVJEMHr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 08:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbVJEMHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 08:07:46 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37334 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965138AbVJEMHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 08:07:45 -0400
Subject: Re: freebox possible GPL violation
From: Arjan van de Ven <arjan@infradead.org>
To: Emmanuel Fleury <fleury@cs.aau.dk>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <4343C0DB.9080506@cs.aau.dk>
References: <20051005111329.GA31087@linux.ensimag.fr>
	 <4343B779.8030200@cs.aau.dk>
	 <1128511676.2920.19.camel@laptopd505.fenrus.org>
	 <4343BB04.7090204@cs.aau.dk>
	 <1128513584.2920.23.camel@laptopd505.fenrus.org>
	 <4343C0DB.9080506@cs.aau.dk>
Content-Type: text/plain
Date: Wed, 05 Oct 2005 14:07:42 +0200
Message-Id: <1128514062.2920.27.camel@laptopd505.fenrus.org>
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

On Wed, 2005-10-05 at 14:02 +0200, Emmanuel Fleury wrote:
> Arjan van de Ven wrote:
> > 
> > that's not enough to satisfy the GPL conditions. 
> 
> It is.

  3. You may copy and distribute the Program (or a work based on it,
under Section 2) in object code or executable form under the terms of
Sections 1 and 2 above provided that you also do one of the following:

    a) Accompany it with the complete corresponding machine-readable
    source code, which must be distributed under the terms of Sections
    1 and 2 above on a medium customarily used for software interchange;
or,

    b) Accompany it with a written offer, valid for at least three
    years, to give any third party, for a charge no more than your
    cost of physically performing source distribution, a complete
    machine-readable copy of the corresponding source code, to be
    distributed under the terms of Sections 1 and 2 above on a medium
    customarily used for software interchange; or,

    c) Accompany it with the information you received as to the offer
    to distribute corresponding source code.  (This alternative is
    allowed only for noncommercial distribution and only if you
    received the program in object code or executable form with such
    an offer, in accord with Subsection b above.)


they don't do a)

they don't do b)

c) is only for noncommerial distribution (not the case here) and only if
they got it in a type b) before, eg it allows you to transfer a type b)
in the non-commerical case.



