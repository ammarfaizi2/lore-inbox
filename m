Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281139AbRKKW7p>; Sun, 11 Nov 2001 17:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281156AbRKKW7f>; Sun, 11 Nov 2001 17:59:35 -0500
Received: from pD958A1BC.dip.t-dialin.net ([217.88.161.188]:18831 "EHLO
	power.suche.org") by vger.kernel.org with ESMTP id <S281139AbRKKW7V> convert rfc822-to-8bit;
	Sun, 11 Nov 2001 17:59:21 -0500
Message-ID: <3BEF028D.6060200@bewegungsmelder.de>
Date: Sun, 11 Nov 2001 22:58:21 +0000
From: Thomas Lussnig <tlussnig@bewegungsmelder.de>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: null, de-de, de, en-gb, en
MIME-Version: 1.0
To: Nicolas Mailhot <Nicolas.Mailhot@LaPoste.net>
CC: linux-kernel@vger.kernel.org, netfilter@lists.samba.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: Iptables & ECN
In-Reply-To: <1005518494.5895.0.camel@rousalka.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>
>	I'm afraid I've just run in an embarassing iptables « bug » on
>2.4.13-ac7. When I tell iptables to drop unclean packets with ecn on I
>can no longuer connect to ftp.kernel.org, and get a lot of ipt_unclean:
>TCP reserved bits not zero in the logs. Shouldn't iptables be made
>ecn-aware ? (especially given all the red-inked comments on ECN in the
>FAQ)
>
Yes,
this is an often discussed problem. An i think it should fixed in the
actuall cvs tree. But its not to hard to fix it self. :-)

Cu Thomas



