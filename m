Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbTIOJbT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 05:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbTIOJbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 05:31:19 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:32519 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S261595AbTIOJbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 05:31:18 -0400
Date: Mon, 15 Sep 2003 11:31:10 +0200
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23-pre4 ide-scsi irq timeout
Message-ID: <20030915093110.GD2268@gamma.logic.tuwien.ac.at>
References: <20030913220121.GA1727@gamma.logic.tuwien.ac.at> <shs3cezap0u.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <shs3cezap0u.fsf@charged.uio.no>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Son, 14 Sep 2003, Trond Myklebust wrote:
>      > I only have patched in cpufreq, nothing else, and I am running
>      > debian/sid.
> 
> I saw the same thing, and have narrowed it down to a possible compiler
> bug. Just drop gcc-3.3, and all will be well.

Hmmm, that sounds very strange, since I used the same gcc for the
previous kernels (pre3 and before), too!?

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
FARNHAM (n.)
The feeling you get about four o'clock in the afternoon when you
haven't got enough done.
			--- Douglas Adams, The Meaning of Liff
