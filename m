Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbVIMRBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbVIMRBQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 13:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbVIMRBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 13:01:16 -0400
Received: from [64.162.99.240] ([64.162.99.240]:23797 "EHLO
	spamtest2.viacore.net") by vger.kernel.org with ESMTP
	id S964889AbVIMRBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 13:01:15 -0400
Message-ID: <432705A0.1070407@spamtest.viacore.net>
Date: Tue, 13 Sep 2005 10:00:16 -0700
From: Joe Bob Spamtest <joebob@spamtest.viacore.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050909 Fedora/1.7.10-1.5.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: Pure 64 bootloaders
References: <4325F3D5.9040109@spamtest.viacore.net> <20050912.144107.37064900.davem@davemloft.net> <4325FADB.4090804@spamtest.viacore.net> <20050912.151230.100651236.davem@davemloft.net> <43260A8D.1090508@spamtest.viacore.net> <20050913165228.GG28578@csclub.uwaterloo.ca>
In-Reply-To: <20050913165228.GG28578@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:
> ia64 also wasn't an extension on an existing 32bit design the way sparc,
> ppc, mips and x86_64 have done.

yeah, the only differene here is that x86_64 performs a hell of a lot
better in 99% of cases where a 32 bit compile performs next to a 64 bit
compile. In the case of the other architectures the 64 bit modes are
extensions of sorts, used for scientific and/or large calculations which
benefit from 64-bit datatypes and transactions.

> Is the alpha also pure 64bit?

Alpha was designed 64-bit from the start. DEC did a lot of neat things
with the design of that processor -- it's a shame it went the way of the
dodo when ia64 was proposed.

> Of course mips is extra fun in having two 32bit formats and one 64bit
> format.

Fun stuff. Another good architecture that bit the ia64 bug and got
stung.
