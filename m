Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265701AbTGCKAB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 06:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265741AbTGCKAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 06:00:01 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:57094 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S265701AbTGCKAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 06:00:00 -0400
Date: Thu, 3 Jul 2003 20:13:51 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
cc: davem@redhat.com, <acme@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
       <netdev@oss.sgi.com>, <mbligh@aracnet.com>
Subject: Re: [PATCH] NET: fix SEGV/OOPS with /proc/net/{raw,igmp,...} (is
 Re: [Bug 863] New: cat /proc/buddyinfo + netstat -a kills machine)
In-Reply-To: <20030703.154429.06241047.yoshfuji@linux-ipv6.org>
Message-ID: <Mutt.LNX.4.44.0307032013200.14369-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jul 2003, YOSHIFUJI Hideaki / [iso-2022-jp] 吉藤英明 wrote:

> I'm not so sure if this is ralated to BUG#863, but anyway;
> 
> Following patch fixes segv/oops with /proc/net/{raw,igmp,mfilter,
> raw6,igmp6,mfilter6,anycast,ip6_flowlabel}.

Applied to bk://kernel.bkbits.net/jmorris/net-2.5

- James
-- 
James Morris
<jmorris@intercode.com.au>

