Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267388AbUI1MWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267388AbUI1MWn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 08:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267536AbUI1MWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 08:22:43 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:37136 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S267388AbUI1MWc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 08:22:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Microsoft claim 267% better peak performance than linux?
Date: Tue, 28 Sep 2004 15:24:25 +0000
X-Mailer: KMail [version 1.4]
References: <20040928075545.GA3298@cenedra.walrond.org>
In-Reply-To: <20040928075545.GA3298@cenedra.walrond.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200409281524.25187.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 September 2004 07:55, Andrew Walrond wrote:
> I was pointed to this (rotating) banner advert at the top of www.eweek.com
>
> It claims that when comparing Red Hat AS2.1 with Windows Server 2003 on a
> dual processor machine, Windows Server 2003 gives 276% better peak
> performance, quoting Veritest as the source.

It is very easy to 'slightly' misconfigure Linux machine so that it
slows to a crawl. For webservers, classic way to do it is to force
Apache to log a fqdn of incoming connections instead of numeric IP.

>From pdf:
> Microsoft commissioned VeriTest, a division of Lionbridge
> Technologies, Inc., to conduct a series of tests comparing
> the Web serving performance of the following server operating
> system configurations running on a variety of server hardware
> and processor configurations...

Do you seriously expect that MS-funded tests can ever find Linux
to be faster?
-- 
vda
