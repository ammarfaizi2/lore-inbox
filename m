Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbTIQLno (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 07:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbTIQLno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 07:43:44 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:6417 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S262729AbTIQLnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 07:43:42 -0400
Date: Wed, 17 Sep 2003 13:43:36 +0200
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: laptop mode for 2.4.23-pre4 and up
Message-ID: <20030917114336.GB17697@gamma.logic.tuwien.ac.at>
References: <20030913103014.GA7535@gamma.logic.tuwien.ac.at> <20030914152755.GA27105@suse.de> <20030915093221.GE2268@gamma.logic.tuwien.ac.at> <20030917075432.GG906@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030917075432.GG906@suse.de>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens!


On Mit, 17 Sep 2003, Jens Axboe wrote:
> Here's a fresh one against current BK, could you please give it a go?

I patched my 2.4.23-pre4 together with some other patches and this one
and it worked. I am still using the laptop-mode.sh script from your
original posting (echo "30 500 0 0 $AGE $AGE 60 20 0" > /proc/sys/vm/bdflush
for start etc)

> +Laptop mode

[...]

> +desribed above. See the laptop-mode.sh script for how to do that.

Should this script be included in the readme? 

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
JAWCRAIG (n. medical)
A massive facial spasm which is brought on by being told a really
astounding piece of news. A mysterious attack of jawcraig affected
40,000 sheep in Whales in 1952.
			--- Douglas Adams, The Meaning of Liff
