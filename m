Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264877AbSKNOAd>; Thu, 14 Nov 2002 09:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264888AbSKNOAd>; Thu, 14 Nov 2002 09:00:33 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:53931 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264877AbSKNOAc>; Thu, 14 Nov 2002 09:00:32 -0500
Subject: Re: module mess in -CURRENT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021114033853.0E63C2C057@lists.samba.org>
References: <20021114033853.0E63C2C057@lists.samba.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Nov 2002 14:32:53 +0000
Message-Id: <1037284373.16000.19.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-14 at 04:36, Rusty Russell wrote:
> 
> Why is PCMCIA broken?

PCMCIA is broken without modules, not broken because of the change (well
it gets rather upset about unload fails but thats a seperate matter)

