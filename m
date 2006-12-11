Return-Path: <linux-kernel-owner+w=401wt.eu-S937106AbWLKTD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937106AbWLKTD4 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 14:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937565AbWLKTDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 14:03:55 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:36504 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937563AbWLKTDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 14:03:54 -0500
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
From: Arjan van de Ven <arjan@infradead.org>
Reply-To: arjan@infradead.org
To: Olaf Hering <olaf@aepfle.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andy Whitcroft <apw@shadowen.org>,
       Herbert Poetzl <herbert@13thfloor.at>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Steve Fox <drfickle@us.ibm.com>
In-Reply-To: <20061211181430.GA18963@aepfle.de>
References: <457D750C.9060807@shadowen.org>
	 <20061211163333.GA17947@aepfle.de>
	 <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org>
	 <20061211175026.GA18628@aepfle.de>
	 <1165859874.27217.382.camel@laptopd505.fenrus.org>
	 <20061211180049.GA18821@aepfle.de>
	 <1165860500.27217.388.camel@laptopd505.fenrus.org>
	 <20061211181430.GA18963@aepfle.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 11 Dec 2006 20:03:21 +0100
Message-Id: <1165863801.27217.406.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> > (or in other words, why is SLES the only one with the problem?)
> 
> Everyone has this "problem". Or how do you know what kernelrelease is
> inside a random ELF or bzImage binary?

I doubt anyone else will let it come to the "random" stage


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

