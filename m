Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbSJ1WDA>; Mon, 28 Oct 2002 17:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261492AbSJ1WDA>; Mon, 28 Oct 2002 17:03:00 -0500
Received: from smtp09.iddeo.es ([62.81.186.19]:24028 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S261530AbSJ1WCx>;
	Mon, 28 Oct 2002 17:02:53 -0500
Date: Mon, 28 Oct 2002 23:09:01 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Max Valdez <maxvaldez@yahoo.com>
Cc: kernel <linux-kernel@vger.kernel.org>
Subject: Re: crc error on boot (2.4.20-pre11 gcc 3.2-mdk)
Message-ID: <20021028220901.GC2118@werewolf.able.es>
References: <1035810541.2675.3.camel@garaged.fis.unam.mx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1035810541.2675.3.camel@garaged.fis.unam.mx>; from maxvaldez@yahoo.com on Mon, Oct 28, 2002 at 14:09:00 +0100
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.10.28 Max Valdez wrote:
>Hi all
>
>I think I'm about to make a stupid question, but still can contain...
>
>Is gcc 3.2 supported to build linux kernel ???, any known problems ???
>
>I have a "crc error" in the first step of the booting process, just
>after lilo screen goes off.
>
>I attach my config file, It's the first time i try to build a kernel
>with gcc 3.2, I havent had big problems before ( gcc 2.9X ) on mandrake
>and redhat.
>

I am building kernels with gcc-3.2 from mdk-9.0 and cooker without problems.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-pre11-jam2 (gcc 3.2 (Mandrake Linux 9.0 3.2-2mdk))
