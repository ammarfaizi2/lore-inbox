Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315792AbSFESTW>; Wed, 5 Jun 2002 14:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315794AbSFESTV>; Wed, 5 Jun 2002 14:19:21 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:15878 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S315792AbSFESTS>; Wed, 5 Jun 2002 14:19:18 -0400
Date: Wed, 5 Jun 2002 20:19:14 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre10-ac2
Message-ID: <20020605181914.GA11479@louise.pinerecords.com>
In-Reply-To: <200206051804.g55I4mK19323@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 1 day, 7:26
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> o	Fix IDE port offset for pdc202xx		(Hang Yang)
> 	| should fix LBA48 drives on primary channel

Btw, the big IDE update seems to have written off the ServerWorks
driver -- DMA mode on OSB4 cannot be enabled no matter what.

Tomas
