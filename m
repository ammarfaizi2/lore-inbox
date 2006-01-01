Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWAAMZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWAAMZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 07:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWAAMZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 07:25:57 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:18656 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751101AbWAAMZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 07:25:57 -0500
Subject: Re: MPlayer broken under 2.6.15-rc7-rt1?
From: Arjan van de Ven <arjan@infradead.org>
To: jerome lacoste <jerome.lacoste@gmail.com>
Cc: Bradley Reed <bradreed1@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <5a2cf1f60601010412r3ec10855s5ad6ed8e0a6f2ef1@mail.gmail.com>
References: <20051231202933.4f48acab@galactus.example.org>
	 <1136106861.17830.6.camel@laptopd505.fenrus.org>
	 <20060101115121.034e6bb7@galactus.example.org>
	 <1136114772.17830.20.camel@laptopd505.fenrus.org>
	 <5a2cf1f60601010412r3ec10855s5ad6ed8e0a6f2ef1@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 01 Jan 2006 13:25:54 +0100
Message-Id: <1136118354.17830.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Although I like the idea of making the vendors of binary modules
> really aware of the costs they introduce with regard to debug issues
> on tainted system, if I was them, the first thing I would say is
> "contact the vendor of the part of the system that changed", i.e. the
> kernel.

the good ones don't, and investigate. The bad ones... do you really want
their code in your kernel??


