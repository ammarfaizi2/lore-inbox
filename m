Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbVKAUqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbVKAUqW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 15:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbVKAUqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 15:46:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60048 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751212AbVKAUqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 15:46:21 -0500
Subject: Re: Would I be violating the GPL?
From: Arjan van de Ven <arjan@infradead.org>
To: "Jeff V. Merkey" <jmerkey@utah-nac.org>
Cc: alex@alexfisher.me.uk, linux-kernel@vger.kernel.org
In-Reply-To: <43679B22.8070905@utah-nac.org>
References: <5449aac20511010949x5d96c7e0meee4d76a67a06c01@mail.gmail.com>
	 <43679B22.8070905@utah-nac.org>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 21:46:09 +0100
Message-Id: <1130877969.2777.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[84.119.168.181 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-01 at 09:43 -0700, Jeff V. Merkey wrote:
> 
> Alan Cox and others have publicly stated that drivers, if complied stand 
> alone with NO DEPENDENCIES ON KERNEL HEADERS (i.e. they do not 
> incorporate in any way any kernel headers or source code tagged GPL)

can you give a reference to that? I can't imagine Alan saying that
(probably the negative of the opposite).. since even without using any
kernel headers you can be a derived work (when/how/what is up to
lawyers, but I assume you can agree that it is possible to create a
kernel module that is a derived work even without the condition you
describe) and in that case it HAS to be GPL. Alan isn't alone in the
position to make that exception, you'd need permission from all kernel
authors, but I also find it sort of hard to believe he said that. 

