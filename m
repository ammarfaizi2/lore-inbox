Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268834AbUIXP3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268834AbUIXP3r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 11:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268800AbUIXP3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 11:29:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:34772 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268831AbUIXP2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 11:28:55 -0400
Date: Fri, 24 Sep 2004 08:22:41 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Timothy Miller <miller@techsource.com>
Cc: vonbrand@inf.utfsm.cl, jgarzik@pobox.com, dwmw2@infradead.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, jeremy@sgi.com
Subject: Re: [DOC] Linux kernel patch submission format
Message-Id: <20040924082241.6bb1c849.rddunlap@osdl.org>
In-Reply-To: <41543786.5090107@techsource.com>
References: <200409221947.i8MJlnSX003715@laptop11.inf.utfsm.cl>
	<41543786.5090107@techsource.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2004 11:04:38 -0400 Timothy Miller wrote:

| 
| 
| Horst von Brand wrote:
| > Timothy Miller <miller@techsource.com> said:
| > 
| >>Does the Linux kernel source tree include a shell script which will 
| >>compare two trees, create patches, and ask the necessary questions so as 
| >>to format the files correctly with all the right stuff?
| > 
| > 
| > diff(1) does what you want...
| 
| So, in addition to producing the difference, diff also asks you all the 
| questions necessary for a Linux kernel submission, properly formats 
| them, and adds them to the diff output?

Of course not.  There is no script in the kernel tree that does
what you asked... but you probably knew that.

Is one really needed?  or maybe a GUI IDE is all that is required.


--
~Randy
MOTD:  Always include version info.
(Again.  Sometimes I think ln -s /usr/src/linux/.config .signature)
