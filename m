Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265102AbSLMQgl>; Fri, 13 Dec 2002 11:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265126AbSLMQgl>; Fri, 13 Dec 2002 11:36:41 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:4557
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265102AbSLMQgk>; Fri, 13 Dec 2002 11:36:40 -0500
Subject: Re: Symlink indirection
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Walrond <andrew@walrond.org>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DF9FAB1.5070504@walrond.org>
References: <3DF9F780.1070300@walrond.org>
	<200212131611.04355.m.c.p@wolk-project.de>  <3DF9FAB1.5070504@walrond.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Dec 2002 17:22:49 +0000
Message-Id: <1039800169.25285.108.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-13 at 15:20, Andrew Walrond wrote:
> Thanks Marc
> 
> 5 is very low isn't it? Certainly marginal for an application I have in 
> mind.

8 is more normal, but their are recursion and stack size considerations

