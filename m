Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261535AbSJIL3R>; Wed, 9 Oct 2002 07:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261541AbSJIL3R>; Wed, 9 Oct 2002 07:29:17 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:33440 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261535AbSJIL3Q>; Wed, 9 Oct 2002 07:29:16 -0400
Subject: Re: Input - Only try to enable extra keys if user requested it [2/3]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021009130123.B367@ucw.cz>
References: <20021009101256.A10748@ucw.cz> <20021009130035.A367@ucw.cz> 
	<20021009130123.B367@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 09 Oct 2002 12:45:31 +0100
Message-Id: <1034163931.1323.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-09 at 12:01, Vojtech Pavlik wrote:
>   Don't try to enable extra keys on IBM/Chicony keyboards as this upsets
>   several notebook keyboards. Until we find a better solution how to detect
>   who are we talking to, we rely on the kernel command line. Use
>   atkbd_set=4 to gain access to the extra keys.

Surely this also wants a runtime option, or do you assume its fixable
somehow ?

