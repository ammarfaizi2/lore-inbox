Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313638AbSE2Qw5>; Wed, 29 May 2002 12:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313687AbSE2Qw4>; Wed, 29 May 2002 12:52:56 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:49143 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313638AbSE2Qw4>; Wed, 29 May 2002 12:52:56 -0400
Subject: Re: [PATCH] 2.5.18 IDE 73
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Gerald Champagne <gerald@io.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020529183343.A19610@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 29 May 2002 18:55:38 +0100
Message-Id: <1022694938.9255.269.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-05-29 at 17:33, Vojtech Pavlik wrote:
> Also for black/whitelists. And we're going to need those, though maybe
> the current data in them is not worth much.

I'm hopeful they still are. The early drives with DMA problems won't
have changed over time, and I've been updating the others when I get
data from vendors. Promise for example recently sent me a couple to add

