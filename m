Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293224AbSCRXKD>; Mon, 18 Mar 2002 18:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293236AbSCRXJw>; Mon, 18 Mar 2002 18:09:52 -0500
Received: from mons.uio.no ([129.240.130.14]:61429 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S293224AbSCRXJk>;
	Mon, 18 Mar 2002 18:09:40 -0500
To: Pavel Machek <pavel@suse.cz>
Cc: Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        Jonathan Barker <jbarker@ebi.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: VFS mediator?
In-Reply-To: <E16lej0-0002FE-00@the-village.bc.nu>
	<Pine.GSO.4.21.0203141825070.329-100000@weyl.math.psu.edu>
	<20020318192502.GD194@elf.ucw.cz> <shs1yeha5b4.fsf@charged.uio.no>
	<20020318223827.GD1740@atrey.karlin.mff.cuni.cz>
	<15510.28326.558485.955067@charged.uio.no>
	<20020318225403.GE1740@atrey.karlin.mff.cuni.cz>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 19 Mar 2002 00:05:36 +0100
Message-ID: <shs8z8p5ven.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Pavel Machek <pavel@suse.cz> writes:

     > Sorry, this thread was about userland filesystems, and NFS is
     > just not usefull there (for read/write case).

Nope. The point made in Alan's mail early on in the thread was that of
platform independence: the latter has nothing to do with userland
implementation or not. In fact, several of the filesystems Al
mentioned had no (known) userland implementation.

Cheers,
  Trond
