Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261291AbSJLW0l>; Sat, 12 Oct 2002 18:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261299AbSJLW0k>; Sat, 12 Oct 2002 18:26:40 -0400
Received: from transport.cksoft.de ([62.111.66.27]:58628 "EHLO
	transport.cksoft.de") by vger.kernel.org with ESMTP
	id <S261291AbSJLW0k>; Sat, 12 Oct 2002 18:26:40 -0400
Date: Sat, 12 Oct 2002 22:32:36 +0000 (UTC)
From: "Bjoern A. Zeeb" <bzeeb-lists@lists.zabbadoz.net>
X-X-Sender: bz@e0-0.zab2.int.zabbadoz.net
To: Ed Tomlinson <tomlins@cam.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.41+ shutdown problems
In-Reply-To: <200210110840.37464.tomlins@cam.org>
Message-ID: <Pine.BSF.4.44.0210122231240.717-100000@e0-0.zab2.int.zabbadoz.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Oct 2002, Ed Tomlinson wrote:

> All version of 2.5.41-mm and 2.5.41-bk are giving me an oops like the
> following during shutdown:

[snip]

patch was sent to lkml and is fixed in later bk resp 2.5.42 I guess.
Just do a pull and get the next one ;-)))

-- 
Bjoern A. Zeeb				bzeeb at Zabbadoz dot NeT
56 69 73 69 74				http://www.zabbadoz.net/

