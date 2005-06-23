Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262894AbVFWXmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262894AbVFWXmt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 19:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262900AbVFWXmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 19:42:49 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:43957 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262894AbVFWXkh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 19:40:37 -0400
Subject: Re: reiser4 plugins
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael Dreher <michael.dreher@uni-konstanz.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, ninja@slaphack.com,
       reiser@namesys.com, jgarzik@pobox.com, hch@infradead.org, akpm@osdl.org,
       reiserfs-list@namesys.com
In-Reply-To: <200506232249.47302.michael.dreher@uni-konstanz.de>
References: <42BAC304.2060802@slaphack.com>
	 <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl>
	 <20050623221222.33074838.reiser4@blinkenlights.ch>
	 <200506232249.47302.michael.dreher@uni-konstanz.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119569841.17066.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 24 Jun 2005 00:37:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-06-23 at 21:49, Michael Dreher wrote:
> My impression: reiser3 is not 100% stable, but quite stable, 
> written by someone who asks for "review by benchmark".

Review by uniprocessor benchmark perhaps. However Reiser4 is new code.
The original extfs on Linux was not very good either while ext2 was
excellent. It seems inappropriate to technically review one fs based on
the other. Looking at the authors maintenance record I think is
important but every single star Linux kernel contributors first major
contribution was generally not very good.

Alan

