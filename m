Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262426AbUJ0NGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbUJ0NGt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 09:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbUJ0NEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 09:04:50 -0400
Received: from canuck.infradead.org ([205.233.218.70]:40712 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262426AbUJ0NB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 09:01:56 -0400
Subject: Re: 2.4.28-rc1, more lost patches [6/10]
From: Arjan van de Ven <arjan@infradead.org>
To: "O.Sezer" <sezeroz@ttnet.net.tr>
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
In-Reply-To: <417F98E1.4050309@ttnet.net.tr>
References: <20041027094036.KAGS6935.fep01.ttnet.net.tr@localhost>
	 <1098871777.4680.15.camel@laptop.fenrus.org>
	 <417F98E1.4050309@ttnet.net.tr>
Content-Type: text/plain
Message-Id: <1098882108.6990.7.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Wed, 27 Oct 2004 15:01:48 +0200
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

On Wed, 2004-10-27 at 15:47 +0300, O.Sezer wrote:

> 
> Do you think this would change 2.4-cdrom behavior incompatibly?
> It is not that extreme I think...

wrong question ;)
for a very frozen tree like 2.4... the question is: what is the pressing reason to add this.
Not: why not add it.


