Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030697AbWAKADq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030697AbWAKADq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 19:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030700AbWAKADq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 19:03:46 -0500
Received: from outgoing.tpinternet.pl ([193.110.120.20]:54240 "EHLO
	outgoing.tpinternet.pl") by vger.kernel.org with ESMTP
	id S1030697AbWAKADp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 19:03:45 -0500
In-Reply-To: <20060110205709.GE3911@stusta.de>
References: <20060110205709.GE3911@stusta.de>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <52078AC1-B781-4664-A03A-1DC84C84490B@neostrada.pl>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Marcin Dalecki <dalecki.marcin@neostrada.pl>
Subject: Re: [2.6 patch] ftape: remove some outdated information from Kconfig files
Date: Wed, 11 Jan 2006 01:03:04 +0100
To: Adrian Bunk <bunk@stusta.de>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2006-01-10, at 21:57, Adrian Bunk wrote:

> This patch removes some outdated information about the ftape driver  
> like
> pointers to no longer existing webpages from Kconfig files.

You could just remove this driver completely as well. Because  
practically since
it's inclusion in to the main stream kernel it has been outdated and  
nonfunctioning.

1. Formerly the actually usable driver has actually maintained under  
the URL data you remove.
2. Nobody ever cared to synchronize the maintained driver and the in  
kernel one.
3. The physical recording format in the driver provided with the  
kernel is broken.
4. Right now the corresponding user space tools can't be found on the  
web any longer.
5. I'm not talking about years. Its more then 5 years in this case.
