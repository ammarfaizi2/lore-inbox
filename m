Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265388AbTLHNMJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 08:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265395AbTLHNMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 08:12:09 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:62468 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S265388AbTLHNMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 08:12:06 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Mikael Johansson <mpjohans@pcu.helsinki.fi>
Subject: Re: RAID-0 read perf. decrease after 2.4.20
Date: Mon, 8 Dec 2003 14:11:04 +0100
User-Agent: KMail/1.5.4
Cc: linux-raid@vger.kernel.org, <linux-kernel@vger.kernel.org>,
       <riel@redhat.com>, <knobi@knobisoft.de>, Jens Axboe <axboe@suse.de>,
       <mason@suse.com>
References: <Pine.LNX.4.44.0312080949520.889-100000@logos.cnet>
In-Reply-To: <Pine.LNX.4.44.0312080949520.889-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312081411.04057.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 December 2003 13:47, Marcelo Tosatti wrote:

Hi Marcelo,

> 2.4.20-aa included rmap and some VM modifications most notably
> "drop_behind()" logic which I believe should be the reason for the huge
> read speedups. Can you please try it? Against 2.4.23.

-aa tree never had -rmap :)

ciao, Marc

