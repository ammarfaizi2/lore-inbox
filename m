Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263531AbTIHTe3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 15:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263552AbTIHTe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 15:34:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:63936 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263531AbTIHTe2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 15:34:28 -0400
Date: Mon, 8 Sep 2003 12:28:53 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: torvalds@osdl.org, aebr@win.tue.nl, willy@debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use size_t for the broken ioctl numbers
Message-Id: <20030908122853.65bff9df.rddunlap@osdl.org>
In-Reply-To: <20030908204023.A1060@pclin040.win.tue.nl>
References: <20030908123846.GA15553@win.tue.nl>
	<Pine.LNX.4.44.0309080812200.11840-100000@home.osdl.org>
	<20030908204023.A1060@pclin040.win.tue.nl>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Sep 2003 20:40:23 +0200 Andries Brouwer <aebr@win.tue.nl> wrote:

| [That reminds me - you announced sparse, a source checker.
| Is it available for non bk users? I haven't seen a URL.]

Dave Jones puts snapshots of it at
http://www.codemonkey.org.uk/projects/sparse/

--
~Randy
