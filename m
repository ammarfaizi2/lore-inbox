Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265331AbUHDNTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265331AbUHDNTG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 09:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265396AbUHDNTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 09:19:05 -0400
Received: from serwer.tvgawex.pl ([212.122.214.2]:3238 "HELO
	mother.ds.pg.gda.pl") by vger.kernel.org with SMTP id S265331AbUHDNTA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 09:19:00 -0400
Date: Wed, 4 Aug 2004 15:19:20 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.8-rc2-bk] New read/write bug in FAT fs
Message-ID: <20040804131920.GA8045@irc.pl>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
References: <4110CF29.8060401@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4110CF29.8060401@myrealbox.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2004 at 04:57:29AM -0700, walt wrote:
> One of the changesets posted by Linus on August 2 introduced
> a bug in the FAT fs:
> 
> Even when a fat32 fs is mounted read-write I now get error
> messages claiming the fs is 'read-only' when I try to write
> to it.

http://linus.bkbits.net:8080/linux-2.5/cset@1.1878?nav=index.html|ChangeSet@-4d

-- 
Tomasz Torcz                 "God, root, what's the difference?" 
zdzichu@irc.-nie.spam-.pl         "God is more forgiving."   

