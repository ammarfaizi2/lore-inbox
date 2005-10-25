Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbVJYHyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbVJYHyn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 03:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbVJYHym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 03:54:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:54735 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932079AbVJYHym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 03:54:42 -0400
Subject: Re: strings /proc/kcore
From: Arjan van de Ven <arjan@infradead.org>
To: com bio <combiofriends@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051024221257.43044.qmail@web32811.mail.mud.yahoo.com>
References: <20051024221257.43044.qmail@web32811.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Tue, 25 Oct 2005 09:53:57 +0200
Message-Id: <1130226838.3125.3.camel@laptopd505.fenrus.org>
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

On Mon, 2005-10-24 at 15:12 -0700, com bio wrote:
> Hello,
>   When i do #strings /proc/kcore as root i get the
> following error.
> strings: /proc/kcore: Operation not permitted

eh you do realize that this is extremely silly to do right?


> I run fedora core 3. My kernel version is 2.6.9-1.667.
> I would be happy if someone can help me diagnise this
> error. Thanks

why do you want to do this?


