Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbTIKSnE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 14:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbTIKSnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 14:43:04 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:44178 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261444AbTIKSmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 14:42:38 -0400
Subject: Re: Size of Tasks during ddos
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Breno <brenosp@brasilsec.com.br>
Cc: Valdis.Kletnieks@vt.edu, Stan Bubrouski <stan@ccs.neu.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <009f01c3788a$08b7f780$9f0210ac@forumci.com.br>
References: <001b01c39047$d65cf580$f8e4a7c8@bsb.virtua.com.br>
	 <20030911002755.GA13177@triplehelix.org> <3F5FD993.2060900@ccs.neu.edu>
	 <009201c37860$f0d3c5f0$131215ac@poslab219>
	 <200309111419.h8BEJbSo010948@turing-police.cc.vt.edu>
	 <009f01c3788a$08b7f780$9f0210ac@forumci.com.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063305670.3605.0.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Thu, 11 Sep 2003 19:41:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-09-11 at 18:27, Breno wrote:
> This is a Syn Flood DDoS 

echo "1" >/proc/sys/net/ipv4/tcp_syncookies

End of problem.

