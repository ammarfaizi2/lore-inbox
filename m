Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbVCNSvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbVCNSvi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 13:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbVCNSpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 13:45:12 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:25329 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261680AbVCNSmw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 13:42:52 -0500
Date: Mon, 14 Mar 2005 19:42:50 +0100 (CET)
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
To: Wiktor <victorjan@poczta.onet.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Building server-farm
In-Reply-To: <4235D474.1000102@poczta.onet.pl>
Message-ID: <Pine.LNX.4.62.0503141931500.30586@iceowl.ott.dyndns.info>
References: <4235D474.1000102@poczta.onet.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You'll can use OpenMosix 
(http://sourceforge.net/project/openmosix) or Mosix 
(http://www.mosix.org/).

Have a look at:
http://www.mini-itx.com/projects/cluster/
http://en.wikipedia.org/wiki/Beowulf_%28computing%29
http://de.wikipedia.org/wiki/BeowulfProject2004 (German, it describes 
howto setup a cluster)
http://216.239.39.104/translate_c?hl=de&ie=UTF-8&oe=UTF-8&langpair=de%7Cen&u=http://de.wikipedia.org/wiki/BeowulfProject2004&prev=/language_tools 
(Translation of the German Article)

Matthias-Christian Ott

On Mon, 14 Mar 2005, Wiktor wrote:

> Hi,
>
> I'm looking for a way to connect multiple linux systems into one big machine 
> (server-farm) and I can't find any way of enabling it in kernel.  Is this 
> feature supported? If not, how can I build cluster from, let's say, 5 
> machines (I'm interestied in sharing of processes, memory, disk space and 
> network interface). Thanks for replies.
>
> --
> May the Source be with you
> Wiktor
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
