Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbTBJEgE>; Sun, 9 Feb 2003 23:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261660AbTBJEgD>; Sun, 9 Feb 2003 23:36:03 -0500
Received: from palrel12.hp.com ([156.153.255.237]:50095 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id <S261645AbTBJEgB>;
	Sun, 9 Feb 2003 23:36:01 -0500
Message-ID: <3E472BBE.70707@india.hp.com>
Date: Mon, 10 Feb 2003 10:04:06 +0530
From: vishwas@india.hp.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020815
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shawn Starr <spstarr@sh0n.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG?][2.4.xx] - SB Driver (SBAWE32) -  Explosion sound on init
References: <200302092303.44114.spstarr@sh0n.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn Starr wrote:

> Odd, When I boot up with 2.4.20 and the sound driver is about to init.

  Some init script which restores the mixer setting might be causing this.


