Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbTDMSuq (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 14:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbTDMSuq (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 14:50:46 -0400
Received: from ca-fulrtn-cuda2-c6a-113.anhmca.adelphia.net ([68.66.9.113]:49283
	"EHLO shrike.mirai.cx") by vger.kernel.org with ESMTP
	id S261474AbTDMSup (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 14:50:45 -0400
Message-ID: <3E99B449.7070708@tmsusa.com>
Date: Sun, 13 Apr 2003 12:02:33 -0700
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.67-mm2
References: <20030413031440.GA14357@holomorphy.com>	<200304130350.h3D3o8pn031108@sith.maoz.com> <20030412214214.57a87776.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>This should fix it up.
>
> include/linux/spinlock.h |   14 +++++++-------
> 1 files changed, 7 insertions(+), 7 deletions(-)
>
Yes with that patch it works a charm.

Pounding the box now with no problems,

Joe


