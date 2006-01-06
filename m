Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbWAFTBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWAFTBA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 14:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWAFTBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 14:01:00 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:19339 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932460AbWAFTA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 14:00:58 -0500
Subject: Re: [patch 2/7]  enable unit-at-a-time optimisations for gcc4
From: Arjan van de Ven <arjan@infradead.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, mingo@elte.hu
In-Reply-To: <20060106184841.GA13917@mars.ravnborg.org>
References: <1136543825.2940.8.camel@laptopd505.fenrus.org>
	 <1136543914.2940.11.camel@laptopd505.fenrus.org>
	 <43BEA672.4010309@pobox.com>  <20060106184841.GA13917@mars.ravnborg.org>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 20:00:52 +0100
Message-Id: <1136574052.2940.68.camel@laptopd505.fenrus.org>
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


> Also why should we care so much for multi directory modules?

I suspect Jeff didn't mean it like that, but instead assumed that
multi-directory would be harder so that starting with single-directory
would be a good start...

