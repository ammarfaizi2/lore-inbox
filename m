Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316972AbSEWSEG>; Thu, 23 May 2002 14:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316974AbSEWSEF>; Thu, 23 May 2002 14:04:05 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:36369 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S316972AbSEWSEE>; Thu, 23 May 2002 14:04:04 -0400
Date: Thu, 23 May 2002 20:03:57 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "Gryaznova E." <grev@namesys.botik.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE problem: linux-2.5.17
Message-ID: <20020523180357.GA725@louise.pinerecords.com>
In-Reply-To: <3CECF59B.D471F505@namesys.botik.ru> <3CECFA15.8040707@evision-ventures.com> <3CED2B73.ABA3C95F@namesys.botik.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: GNU/Linux 2.2.21 SMP
X-Architecture: sparc
X-Uptime: 21:50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have 40 wires cable. When ide=nodma is passed to 2.5.17 kernel -
> kernel boots. Am I correct that it is not possible to have DMA
> on with such cable? Is there any reason for doing that?

40-conductor IDE cables are capable of transfering data
in DMA modes up to udma2, but no faster.

T.
