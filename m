Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262839AbTJJOrI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 10:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbTJJOrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 10:47:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:35795 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262839AbTJJOrF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 10:47:05 -0400
Date: Fri, 10 Oct 2003 07:37:50 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Norman Diamond" <ndiamond@wta.att.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test7 and HIDBP
Message-Id: <20031010073750.001ad559.rddunlap@osdl.org>
In-Reply-To: <1f8801c38f11$da95c410$5cee4ca5@DIAMONDLX60>
References: <1f8801c38f11$da95c410$5cee4ca5@DIAMONDLX60>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Oct 2003 18:34:45 +0900 "Norman Diamond" <ndiamond@wta.att.ne.jp> wrote:

| OK, I already know that I'm half-blind, but now either I'm 75% blind or else
| these are facts:
| 
| make xconfig has options for HIDBP.
| make gconfig doesn't.
| 
| Of course I want full HID so this might not matter, but I have memories of
| needing HIDBP a few years ago.

I don't know about gconfig, but you don't want or need HIDBP with full HID.

--
~Randy
