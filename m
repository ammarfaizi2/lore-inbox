Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262485AbSI2OZt>; Sun, 29 Sep 2002 10:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262487AbSI2OZs>; Sun, 29 Sep 2002 10:25:48 -0400
Received: from franka.aracnet.com ([216.99.193.44]:10434 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262485AbSI2OZr>; Sun, 29 Sep 2002 10:25:47 -0400
Date: Sun, 29 Sep 2002 07:28:43 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Zach Brown <zab@zabbo.net>, Ingo Molnar <mingo@elte.hu>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.39 list_head debugging
Message-ID: <673209954.1033284520@[10.10.2.3]>
In-Reply-To: <20020929102731.A13755@bitchcake.off.net>
References: <20020929102731.A13755@bitchcake.off.net>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> and we could as well add these unconditionally (no .config complexity
>> needed), until 2.6.0 or so, hm?
> 
> I'd love that.  It was just a bit of sugar to help the medicine go down.

Could you leave the config option in, and just default it to on?
Some of us are foolish enough to be doing benchmarking on 2.5 - 
we need to do the performance tweaking ;-)

M.

