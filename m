Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263470AbTICPjI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 11:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263494AbTICPjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 11:39:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:37329 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263470AbTICPjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 11:39:05 -0400
Date: Wed, 3 Sep 2003 08:33:34 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Stevo" <stevo@cool3dz.com>
Cc: linux-kernel@vger.kernel.org, shampton@tsiconnections.com
Subject: Re: (Simple) Basic Design Flaw in make menuconfig GUI
Message-Id: <20030903083334.6a98a4f5.rddunlap@osdl.org>
In-Reply-To: <001f01c37229$4bbd0410$1400a8c0@gaussian>
References: <001f01c37229$4bbd0410$1400a8c0@gaussian>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003 10:40:17 -0400 "Stevo" <stevo@cool3dz.com> wrote:

| PROBLEM: (ocassionally) While I am speeding through the kernel
| configuration, I will accidentally hit the "Esc" key one too many times (I'm
| sure we've all done this) and it will leave me at the "exit" screen:
| 
|                         Do you wish to save your new kernel config?
| 
|                                            <Yes>     <No>
| 
| In this case, neither choice is acceptable. In a plea to save time for all,
| can someone please add one more simple choice to the "exit" menu?
| 
|                         Do you wish to save your new kernel config?
| 
|                              <Yes>     <No>     <Return to Config>

Yes, I've needed that choice at times also.

--
~Randy
