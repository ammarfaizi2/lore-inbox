Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264670AbSJTXks>; Sun, 20 Oct 2002 19:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264671AbSJTXks>; Sun, 20 Oct 2002 19:40:48 -0400
Received: from mail.storm.ca ([209.87.239.66]:18668 "EHLO mail.storm.ca")
	by vger.kernel.org with ESMTP id <S264670AbSJTXks>;
	Sun, 20 Oct 2002 19:40:48 -0400
Message-ID: <3DB41338.3070502@storm.ca>
Date: Mon, 21 Oct 2002 07:46:16 -0700
From: Sandy Harris <sandy@storm.ca>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mitsuru KANDA <mk@linux-ipv6.org>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       cryptoapi-devel@kerneli.org, design@lists.freeswan.org,
       usagi@linux-ipv6.org
Subject: Re: [Design] [PATCH] USAGI IPsec
References: <m3k7kpjt7c.wl@karaba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mitsuru KANDA wrote:

>Hello Linux kernel network maintainers,
>
>I'm a member of USAGI project.
>
>In IPv6 specifications, IPsec is mandatory.
>
>We implemented IPsec for Linux IP stack.
>
>At present, our implementation includes:
>	PF_KEY V2 interface,
>	Security Association Database and
>	Security Policy Database for whole IP versions,
>	IPsec for IPv6,(transport, tunnel mode),
>	IPsec for IPv4 (transport mode),
>
>Would you mind checking it ?
>
Is this code being checked in to the mainline kernel? Or becoming part 
of the
CryptoAPI patch set? Bravo, in either case.

How does that affect FreeS/WAN development?

>  
>

