Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932091AbWFFEy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWFFEy5 (ORCPT <rfc822;akpm@zip.com.au>);
	Tue, 6 Jun 2006 00:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWFFEy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 00:54:57 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:61116 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932091AbWFFEy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 00:54:57 -0400
Subject: Re: [patch] i386: print NUMA in oops messages
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, linux-kernel@vger.kernel.org,
        torvalds@osdl.org
In-Reply-To: <20060605211855.d92dab53.akpm@osdl.org>
References: <200606052303_MC3-1-C1B2-7E2C@compuserve.com>
	 <20060605211855.d92dab53.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 06 Jun 2006 06:54:51 +0200
Message-Id: <1149569691.3116.23.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This is too cute for my taste.  Keep it simple.

why not just print the vermagic string then?
(and if needed, we should add NUMA to that)


