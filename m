Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965110AbVJEL2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965110AbVJEL2I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 07:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965112AbVJEL2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 07:28:08 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:23016 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965110AbVJEL2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 07:28:06 -0400
Subject: Re: freebox possible GPL violation
From: Arjan van de Ven <arjan@infradead.org>
To: Emmanuel Fleury <fleury@cs.aau.dk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4343B779.8030200@cs.aau.dk>
References: <20051005111329.GA31087@linux.ensimag.fr>
	 <4343B779.8030200@cs.aau.dk>
Content-Type: text/plain
Date: Wed, 05 Oct 2005 13:27:56 +0200
Message-Id: <1128511676.2920.19.camel@laptopd505.fenrus.org>
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


> Your task will be to prove that the kernel they upload to your box is a
> modified Linux kernel (by "modified Linux kernel", I mean no modules but
> the kernel itself).
> 
> So, the first step would be to catch/sniff this binary image, then
> analyze it.
> 
> But, as long as you cannot prove that Free has done internal
> modifications to the Linux kernel which are not released in any way,
> your case is quite thin.

why?

The GPL holds modified or not...

(and that includes drivers if they are distributed together with the gpl
kernel as part of a bigger work)

