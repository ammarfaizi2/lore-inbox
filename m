Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVBGUZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVBGUZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 15:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVBGUV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 15:21:28 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:2218 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S261320AbVBGUTy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 15:19:54 -0500
Message-ID: <4207CD63.1080802@namesys.com>
Date: Mon, 07 Feb 2005 12:19:47 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3-mm1 bad scheduling while atomic + lockup
References: <1865944987.20050207081532@dns.toxicfilms.tv>
In-Reply-To: <1865944987.20050207081532@dns.toxicfilms.tv>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Soltysiak wrote:

>)
>
>Feb  6 17:07:47 dns kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
>Feb  6 17:07:47 dns kernel: hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
>  
>
this means bad hard drive, or at least a bad sector on it.
