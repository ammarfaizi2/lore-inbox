Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265670AbRGCJcI>; Tue, 3 Jul 2001 05:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265660AbRGCJb6>; Tue, 3 Jul 2001 05:31:58 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:27828 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S265673AbRGCJb4>; Tue, 3 Jul 2001 05:31:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Florian Schmitt <florian@galois.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Problem with SMC Etherpower II + kernel newer 2.4.2
Date: Tue, 3 Jul 2001 11:31:42 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <3B40611D.F1485C1B@N-Club.de>
In-Reply-To: <3B40611D.F1485C1B@N-Club.de>
MIME-Version: 1.0
Message-Id: <01070311300700.00765@phoenix>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Does anybody else got these errors or knows about a solution for this ??

Same problem here, it won't run at all on newer kernels. But it isn't even 
100% stable in 2.2.x here - on very high network traffic the card stops 
working. In this case, it helps to pull the network plug for a short time, 
then everything goes back to normal. I reduced speed to 10MB, and now it is 
stable at least in 2.2.x. 
Any suggestions would be greatly appreciated. I even put the card into 
another pci slot with exactly zero effect.
There are drivers on smc.com, but they won't help either :-( 
