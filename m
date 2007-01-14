Return-Path: <linux-kernel-owner+w=401wt.eu-S1751351AbXANQpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbXANQpI (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 11:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbXANQpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 11:45:07 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:54817 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbXANQpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 11:45:06 -0500
Subject: Re: [patch] disable NMI watchdog by default
From: Arjan van de Ven <arjan@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20070114092926.GA14465@elte.hu>
References: <20070114092926.GA14465@elte.hu>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 14 Jan 2007 08:45:00 -0800
Message-Id: <1168793100.3123.920.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Signed-off-by: Ingo Molnar <mingo@elte.hu>

Fully agree!
NMI watchdog is high risk in terms of interacting with firmware and
other things (and the code is sort of broken anyway)

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>


