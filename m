Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932594AbVIOTHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbVIOTHg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 15:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbVIOTHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 15:07:36 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:7627 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S932441AbVIOTHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 15:07:35 -0400
Message-ID: <4329C671.2000506@lsrfire.ath.cx>
Date: Thu, 15 Sep 2005 21:07:29 +0200
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Danny ter Haar <dth@cistron.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc1-git1.bz: permission problem?
References: <dgcfb3$c8q$1@news.cistron.nl>
In-Reply-To: <dgcfb3$c8q$1@news.cistron.nl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danny ter Haar wrote:
> lftp ftp.kernel.org:/pub/linux/kernel/v2.6/snapshots> get patch-2.6.14-rc1-git1.gz
> 155962 bytes transferred in 2 seconds (63.8K/s)
> 
> lftp ftp.kernel.org:/pub/linux/kernel/v2.6/snapshots> get patch-2.6.14-rc1-git1.bz
> get: Access failed: 550 Failed to open file. (patch-2.6.14-rc1-git1.bz)

Try "get patch-2.6.14-rc1-git1.bz2". :-)

René
