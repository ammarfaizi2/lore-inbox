Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbTIKWKr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 18:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbTIKWKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 18:10:47 -0400
Received: from [65.248.4.67] ([65.248.4.67]:60364 "EHLO verdesmares.com")
	by vger.kernel.org with ESMTP id S261570AbTIKWKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 18:10:45 -0400
Message-ID: <008901c39044$597dd320$f8e4a7c8@bsb.virtua.com.br>
From: "Breno" <brenosp@brasilsec.com.br>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Kernel List" <linux-kernel@vger.kernel.org>
References: <001b01c39047$d65cf580$f8e4a7c8@bsb.virtua.com.br> <20030911002755.GA13177@triplehelix.org> <3F5FD993.2060900@ccs.neu.edu> <009201c37860$f0d3c5f0$131215ac@poslab219> <200309111419.h8BEJbSo010948@turing-police.cc.vt.edu> <009f01c3788a$08b7f780$9f0210ac@forumci.com.br> <1063305670.3605.0.camel@dhcp23.swansea.linux.org.uk> <002801c3789e$7a665ac0$9f0210ac@forumci.com.br> <1063312815.3886.0.camel@dhcp23.swansea.linux.org.uk>
Subject: Re: Size of Tasks during ddos
Date: Sat, 11 Oct 2003 19:09:30 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-XTmail: http://www.verdesmares.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suppose that one task during a ddos receive much data , so it can try to
alloc much memory to control this data, or to control the list of sockets in
listen state.

att
Breno
----- Original Message -----
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: "Breno" <brenosp@brasilsec.com.br>
Sent: Thursday, September 11, 2003 5:40 PM
Subject: Re: Size of Tasks during ddos


On Iau, 2003-09-11 at 20:54, Breno wrote:
> Alan
>
> This is not the point. I´d like to know about size of tasks in memory .

What does a synflood attack have to do with that. There is no reason
they should change


