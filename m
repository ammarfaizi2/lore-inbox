Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759275AbWLAJ0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759275AbWLAJ0z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 04:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759277AbWLAJ0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 04:26:55 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:53961 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1759275AbWLAJ0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 04:26:54 -0500
Subject: RE: [2.6 patch] Tigran Aivazian: remove bouncing email addresses
From: Arjan van de Ven <arjan@infradead.org>
Reply-To: arjan@infradead.org
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: Hua Zhong <hzhong@gmail.com>, "'Adrian Bunk'" <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0612010919170.29499@ginsburg.homenet>
References: <00e401c7150e$061da500$6721100a@nuitysystems.com>
	 <1164964119.3233.56.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0612010919170.29499@ginsburg.homenet>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 01 Dec 2006 10:26:51 +0100
Message-Id: <1164965211.3233.58.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Or maybe MODULE_AUTHOR shouldn't contain the email address, if the module 
> is mentioned in the MAINTAINERS which does contain it? Why repeat the data 
> and so have to remember to maintain it?

MODULE_AUTHOR is actually nicer than MAINTAINERS in many ways; for
example end users can see it with "modinfo". Also for non-kernel experts
it's not always easy to map module names to the descriptions in the
MAINTAINERS file...


