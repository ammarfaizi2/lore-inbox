Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261339AbSJUMNY>; Mon, 21 Oct 2002 08:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261341AbSJUMNY>; Mon, 21 Oct 2002 08:13:24 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:63155 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261339AbSJUMNY>; Mon, 21 Oct 2002 08:13:24 -0400
Subject: Re: [PATCH] Voyager subarchitecture for 2.5.44
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021019063230.GE23425@holomorphy.com>
References: <200210190612.g9J6Cqu11812@localhost.localdomain> 
	<20021019063230.GE23425@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 13:35:08 +0100
Message-Id: <1035203709.27318.73.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-19 at 07:32, William Lee Irwin III wrote:
> Also, I'd like to say this patch is impressively isolated from generic
> i386 code. Although I've not tested, it seems very clear from the form
> of the code that it will have no impact on UP i386 or other subarches.

Its been in -ac for ages - it doesnt cause problems. Would be nice if
James had an update diff btw;)

