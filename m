Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbUKIIXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbUKIIXB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 03:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbUKIIXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 03:23:00 -0500
Received: from canuck.infradead.org ([205.233.218.70]:47623 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261435AbUKIIW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 03:22:59 -0500
Subject: Re: 2.6.10-rc1-mm3
From: Arjan van de Ven <arjan@infradead.org>
To: Olivier Poitrey <olivier@pas-tres.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, mingo@elte.hu,
       Andries Brouwer <Andries.Brouwer@cwi.nl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, diffie@blazebox.homeip.net,
       Greg KH <greg@kroah.com>, diffie@gmail.com
In-Reply-To: <792238A4-3224-11D9-9F1E-000D934362B4@pas-tres.net>
References: <9dda349204110611043e093bca@mail.gmail.com>
	 <20041107024841.402c16ed.akpm@osdl.org> <20041108075934.GA4602@elte.hu>
	 <20041107234225.02c2f9b6.akpm@osdl.org> <20041108224259.GA14506@kroah.com>
	 <20041108212747.33b6e14a.akpm@osdl.org>
	 <792238A4-3224-11D9-9F1E-000D934362B4@pas-tres.net>
Content-Type: text/plain
Message-Id: <1099988562.3989.4.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 09 Nov 2004 09:22:43 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.6 (++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (2.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[62.195.31.207 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[62.195.31.207 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-09 at 08:53 +0100, Olivier Poitrey wrote:
> On 9 nov. 04, at 06:27, Andrew Morton wrote:
> 
> > [...] Is there a requirement to support more than 256 legacy ptys?
> 
> Yes it is. For big vserver hosting systems for instance, running like
> 100 vservers per node you can easily hit this limit.

but do you really  need the legacy pty's for that instead of the "modern" ones ?


