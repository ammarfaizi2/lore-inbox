Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266930AbSLKBAZ>; Tue, 10 Dec 2002 20:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266932AbSLKBAZ>; Tue, 10 Dec 2002 20:00:25 -0500
Received: from smtp09.iddeo.es ([62.81.186.19]:53937 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S266930AbSLKBAY>;
	Tue, 10 Dec 2002 20:00:24 -0500
Date: Wed, 11 Dec 2002 02:07:37 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4] Dcache Fastwalk for 2.4.20
Message-ID: <20021211010737.GA2879@werewolf.able.es>
References: <58240000.1039480933@w-hlinder>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <58240000.1039480933@w-hlinder>; from hannal@us.ibm.com on Tue, Dec 10, 2002 at 01:42:13 +0100
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.12.10 Hanna Linder wrote:
>
>Hi Marcelo,
>
>	This patch is a backport of the work Al Viro and I did
>in 2.5 to decrease cacheline bouncing during dcache lookup. This
>also removes path_init and replaces it with path_lookup (hence
>the changes in intermezzo and nfsd) as it is in 2.5.
>	Please consider this for inclusion in the next 2.4.2* release.
>
>Thanks.
>
>Hanna Linder
>IBM Linux Technology Center
>

Is you mailer wrapping the patch ?

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-jam1 (gcc 3.2 (Mandrake Linux 9.1 3.2-4mdk))
