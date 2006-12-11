Return-Path: <linux-kernel-owner+w=401wt.eu-S1763034AbWLKTrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763034AbWLKTrF (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 14:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763038AbWLKTrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 14:47:05 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:41772 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763033AbWLKTrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 14:47:03 -0500
Date: Mon, 11 Dec 2006 20:37:42 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Olaf Hering <olaf@aepfle.de>
cc: Arjan van de Ven <arjan@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Andy Whitcroft <apw@shadowen.org>,
       Herbert Poetzl <herbert@13thfloor.at>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
In-Reply-To: <20061211181430.GA18963@aepfle.de>
Message-ID: <Pine.LNX.4.61.0612112037080.28981@yvahk01.tjqt.qr>
References: <457D750C.9060807@shadowen.org> <20061211163333.GA17947@aepfle.de>
 <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org> <20061211175026.GA18628@aepfle.de>
 <1165859874.27217.382.camel@laptopd505.fenrus.org> <20061211180049.GA18821@aepfle.de>
 <1165860500.27217.388.camel@laptopd505.fenrus.org> <20061211181430.GA18963@aepfle.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 11 2006 19:14, Olaf Hering wrote:
>
>> (or in other words, why is SLES the only one with the problem?)
>
>Everyone has this "problem". Or how do you know what kernelrelease is
>inside a random ELF or bzImage binary?

Why would you even want to know that? (Stirring in the hornets nest,
just add a new mkinitrd option.)


	-`J'
-- 
