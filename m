Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265378AbUBARTb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 12:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265385AbUBARTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 12:19:31 -0500
Received: from edu.joroinen.fi ([194.89.68.130]:17829 "EHLO edu.joroinen.fi")
	by vger.kernel.org with ESMTP id S265378AbUBARTa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 12:19:30 -0500
Date: Sun, 1 Feb 2004 19:19:28 +0200
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To: James Morris <jmorris@redhat.com>
Cc: Jari Ruusu <jariruusu@users.sourceforge.net>,
       Jim Faulkner <jfaulkne@ccs.neu.edu>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: PROBLEM: AES cryptoloop corruption under recent -mm kernels
Message-ID: <20040201171928.GG1254@edu.joroinen.fi>
References: <4006C665.3065DFA1@users.sourceforge.net> <Xine.LNX.4.44.0401151315520.16587-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Xine.LNX.4.44.0401151315520.16587-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 01:16:21PM -0500, James Morris wrote:
> On Thu, 15 Jan 2004, Jari Ruusu wrote:
> 
> > Jim,
> > If you want your data secure, you need to re-encrypt your data anyway.
> > Mainline loop crypto implementation has exploitable vulnerability that is
> > equivalent to back door.
> 
> What exactly is this vulnerability?
> 

http://www.tcs.hut.fi/~mjos/doc/herring061103.pdf

That PDF by Markku-Juhani O. Saarinen discusses about these vulnerabilities,
and has one solution to them.

-- Pasi Kärkkäinen
       
                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.
