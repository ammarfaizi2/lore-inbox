Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbTE2QlA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 12:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbTE2QlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 12:41:00 -0400
Received: from air-2.osdl.org ([65.172.181.6]:65181 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262358AbTE2Qk7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 12:40:59 -0400
Date: Thu, 29 May 2003 09:54:24 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Andy Pfiffer <andyp@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.70] drivers/video/matrox/* -- Any work-in-progress?
Message-Id: <20030529095424.3a7d0d6f.rddunlap@osdl.org>
In-Reply-To: <1054226710.17508.16.camel@andyp.pdx.osdl.net>
References: <1054226710.17508.16.camel@andyp.pdx.osdl.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 May 2003 09:45:10 -0700 Andy Pfiffer <andyp@osdl.org> wrote:

| I'm going through a long list of compile-time warnings for 2.5.70, and I
| see a few from drivers/video/matrox/* .
| 
| Does someone have any work-in-progress patches that I should look at
| before I dive in?
| 
| I have a Matrox board that I can use to help test the code...

Petr posted this yesterday:

I just sent email there yesterday with URL of matroxfb patch I sent to 
Linus for inclusion.

ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/mga-stripdown-2.5.70.gz

                                                    Petr Vandrovec

--
~Randy++
