Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282833AbRLLXuT>; Wed, 12 Dec 2001 18:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282890AbRLLXuK>; Wed, 12 Dec 2001 18:50:10 -0500
Received: from freeside.toyota.com ([63.87.74.7]:46086 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S282833AbRLLXuD>; Wed, 12 Dec 2001 18:50:03 -0500
Message-ID: <3C17ED1D.8B091206@lexus.com>
Date: Wed, 12 Dec 2001 15:49:49 -0800
From: J Sloan <jjs@lexus.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8-1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alp ATICI <atici@math.columbia.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Network related
In-Reply-To: <Pine.LNX.4.40.0112121821260.4894-100000@intel4.math.columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a FAQ -

echo "0" > /proc/sys/net/ipv4/tcp_ecn

cu

jjs

Alp ATICI wrote:

> Hi,
> I have a problem with the 2.4.14 kernel custom compiled on a RedHat 7.2. I
> thought I was very careful in selecting the necessary modules at first.
> Everything works great except that when I want to browse some sites
> I get a "connection timed out". Most of the sites work ok but some
> specific ones like www.nvidia.com, www.sun.com, www.ingdirect.com
> never works and gives the same error. When I boot up with other
> kernel or win2000 everything works fine though:( Maybe this is
> a consequence of some other bigger problem which I couldn't figure
> out so far. It looks like only those sites filter out my http request.
> What modules could I have forgotten to include?
>
> Another question is I don't have ipt_MIRROR, ipt_unclean, ipt_iplimit
> in netfilter modules anymore. What config settings should I set on
> to have these back?
> Thanks a lot,
> Alp
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

