Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132436AbRBEClT>; Sun, 4 Feb 2001 21:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132451AbRBECk7>; Sun, 4 Feb 2001 21:40:59 -0500
Received: from snowbird.megapath.net ([216.200.176.7]:38917 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S132436AbRBECky>;
	Sun, 4 Feb 2001 21:40:54 -0500
Message-ID: <3A7E1345.6080005@megapathdsl.net>
Date: Sun, 04 Feb 2001 18:43:17 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1-ac2 i686; en-US; m18) Gecko/20010203
X-Accept-Language: en
MIME-Version: 1.0
To: dhinds@sonic.net, linux-kernel@vger.kernel.org,
        linux-hotplug-devel@lists.sourceforge.net
Subject: Re: Adding PCMCIA support to the kernel tree -- developers needed.
In-Reply-To: <Pine.LNX.3.96.1010203040618.29269C-100000@mandrakesoft.mandrakesoft.com> <3A7C9BAE.45DB2F09@megapathdsl.net> <3A7DFE77.E055BC14@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As we look into developing PCMCIA support in the
2.4/2.5 kernel trees, in addition to reading the
pcmcia-cs code to learn about problems with specific
devices that need to be handled, David Hinds also
a reference page that lists some a bunch of issues
that are in varying degrees of resolution:

	http://pcmcia-cs.sourceforge.net/ftp/BUGS

This may be a useful resource.  I'll see whether
David has time to update this page with a bit more
detailed explanations of the problems.  Some of the
items are pretty vague.  For example,

	the Asix AX88190 chipset, which has
	several serious bugs and incompatibilities
	that render the regular pcnet_cs driver
	unusable

It would be nice to know exactly what those bugs
and incompatibilities are.  :-)

Anyhow, I hope this helps,

	Miles

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
