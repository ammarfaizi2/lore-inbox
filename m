Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267257AbSK3Ov1>; Sat, 30 Nov 2002 09:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267260AbSK3Ov1>; Sat, 30 Nov 2002 09:51:27 -0500
Received: from smtp09.iddeo.es ([62.81.186.19]:20407 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S267257AbSK3OvZ>;
	Sat, 30 Nov 2002 09:51:25 -0500
Date: Sat, 30 Nov 2002 15:58:49 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: hugang <hugang@soulinfo.com>
Cc: linux-kernel@vger.kernel.org, conman@kolivas.net
Subject: Re: [PATCHSET] Linux 2.4.20-jam0
Message-ID: <20021130145849.GE2517@werewolf.able.es>
References: <20021129233807.GA1610@werewolf.able.es> <20021130143647.1e9a527a.hugang@soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20021130143647.1e9a527a.hugang@soulinfo.com>; from hugang@soulinfo.com on Sat, Nov 30, 2002 at 07:36:47 +0100
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.11.30 hugang wrote:
>On Sat, 30 Nov 2002 00:38:07 +0100
>"J.A. Magallon" <jamagallon@able.es> wrote:
>
>>  - Orlov inode allocator for 2.4
>
>- add andrew morton supper.c patch
>- change the indent to linux standard.
>

Thankks, I will update it.
Just a note for further updates: could you make the patch from /usr/src, 
instead of /usr/src/linux, so it can be applied with patch -p1 ?
It is the standard way...

TIA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-jam0 (gcc 3.2 (Mandrake Linux 9.1 3.2-4mdk))
