Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbTIOUUV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 16:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbTIOUUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 16:20:21 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:27915 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S261539AbTIOUUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 16:20:17 -0400
Date: Mon, 15 Sep 2003 22:20:16 +0200
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23-pre4 ide-scsi irq timeout
Message-ID: <20030915202016.GB30683@gamma.logic.tuwien.ac.at>
References: <20030913220121.GA1727@gamma.logic.tuwien.ac.at> <shs3cezap0u.fsf@charged.uio.no> <20030915093110.GD2268@gamma.logic.tuwien.ac.at> <16229.54852.834931.495479@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16229.54852.834931.495479@charged.uio.no>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Sep 2003, Trond Myklebust wrote:
>      > Hmmm, that sounds very strange, since I used the same gcc for
>      > the previous kernels (pre3 and before), too!?
> 
> If it's gcc-3.3.2-0pre3 (the current most recent gcc in sid) then I

I have here 
[~] gcc --version
gcc (GCC) 3.3.2 20030908 (Debian prerelease)

and my currently running kernel has been compiled with:
Linux version 2.4.23-pre3 (root@gandalf) (gcc-Version 3.3.2 20030908 (Debian prerelease)) #3 Mit Sep 10 08:55:40 CEST 2003

so this *cannot* be the problem! It is the SAME compiler I am running at
the moment.

I am definitely not the opinion that this is the problem, sorry.

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
SPROSTON GREEN (n.)
The violent colour of one of Nigel Rees's jackets, worn when he thinks
he's being elegant.
			--- Douglas Adams, The Meaning of Liff
