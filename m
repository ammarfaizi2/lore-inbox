Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316532AbSIDXuX>; Wed, 4 Sep 2002 19:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316541AbSIDXuX>; Wed, 4 Sep 2002 19:50:23 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:25846
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316532AbSIDXuX>; Wed, 4 Sep 2002 19:50:23 -0400
Subject: Re: X.25 Support in Kernel?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: hps@intermeta.de, linux-kernel@vger.kernel.org
In-Reply-To: <20020904155511.GB4427@conectiva.com.br>
References: <al4ihm$h34$1@forge.intermeta.de>
	<1031136982.2796.9.camel@irongate.swansea.linux.org.uk> 
	<20020904155511.GB4427@conectiva.com.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 05 Sep 2002 00:55:17 +0100
Message-Id: <1031183717.2788.154.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-04 at 16:55, Arnaldo Carvalho de Melo wrote:
> Alan, he is talking about net/llc, not net/802.2 8) IOW, he is talking about
> the procom stuff, that is now also being used by the SNA folks.

In real ether protocol world 802.* includes LLC. We have two directories
for the demux and the session stuff.


