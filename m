Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264724AbRFZBW0>; Mon, 25 Jun 2001 21:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264842AbRFZBWR>; Mon, 25 Jun 2001 21:22:17 -0400
Received: from hacksaw.org ([216.41.5.170]:46263 "EHLO
	habitrail.home.fools-errant.com") by vger.kernel.org with ESMTP
	id <S264724AbRFZBWK>; Mon, 25 Jun 2001 21:22:10 -0400
Message-Id: <200106260121.f5Q1LuE14141@habitrail.home.fools-errant.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.3
To: "Alexander V. Bilichenko" <dmor@7ka.mipt.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: GCC3.0 Produce REALLY slower code! 
In-Reply-To: Your message of "Tue, 26 Jun 2001 04:29:49 +0400."
             <000d01c0fdd7$1c416e60$d55355c2@microsoft> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 25 Jun 2001 21:21:56 -0400
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I haven't gone and looked at every line of assembler, but I'd bet this 
is a hasty characterization.

According to someones recent count there are around 144000 lines of assembler 
in the 2.4.2 kernel.

It seems to me you'd have to jump through a lot of hoops to test this compiler.

Then there's the other question: Why should we test a compiler that seems to 
be quite proprietary? The invitation indicates it uses FLexLM to manage the 
license.

I somehow doubt Linus or just about anyone else is going to care, save for the 
folks in Intel, who can do this for themselves just fine.

But, hey, I won't try and stop you. Have fun.

