Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbSLYUQK>; Wed, 25 Dec 2002 15:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261292AbSLYUQK>; Wed, 25 Dec 2002 15:16:10 -0500
Received: from p15108950.pureserver.info ([217.160.128.7]:64680 "EHLO
	pluto.schiffbauer.net") by vger.kernel.org with ESMTP
	id <S261290AbSLYUQJ> convert rfc822-to-8bit; Wed, 25 Dec 2002 15:16:09 -0500
Date: Wed, 25 Dec 2002 21:24:06 +0100
From: Marc Schiffbauer <marc.schiffbauer@links2linux.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG???] EXT3FS+VM86+/dev/mem+pthread=segfault
Message-ID: <20021225202406.GB18790@lisa>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021225215452.020129b0.nickols_k@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20021225215452.020129b0.nickols_k@mail.ru>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.20-pre11 i686
X-Editor: VIM 6.0
X-Homepage: http://www.links2linux.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Nick Kurshev schrieb am 25.12.02 um 19:54 Uhr:
> Hello!
> 

Hi Nick,

[...]
> 
> Btw, does there exists any way to convert ext3fs to ext2fs safely?
> 

You may try to "mount -t ext2fs" it.

-Marc
-- 
-------------------------------------------
Take back the Net! http://www.anti-dmca.org
-------------------------------------------
