Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316542AbSGIBN0>; Mon, 8 Jul 2002 21:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316614AbSGIBNZ>; Mon, 8 Jul 2002 21:13:25 -0400
Received: from jalon.able.es ([212.97.163.2]:50591 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S316542AbSGIBNZ>;
	Mon, 8 Jul 2002 21:13:25 -0400
Date: Tue, 9 Jul 2002 03:15:36 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: rwhron@earthlink.net, linux-kernel@vger.kernel.org
Subject: Re: pipe and af/unix latency differences between aa and jam on smp
Message-ID: <20020709011536.GC1835@werewolf.able.es>
References: <20020709005901.GA9616@rushmore> <20020709011133.GA1835@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020709011133.GA1835@werewolf.able.es>; from jamagallon@able.es on Tue, Jul 09, 2002 at 03:11:33 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.07.09 J.A. Magallon wrote:
>
>
>I have a rc1-jam2 ready, but the only important change wrt SMP could be the
>mem-barrier specific implementation for P3/P4, and your box is an AMD.
>

Opps, I remembered your tests are done on a Quad Xeon ?

-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-rc1-jam2, Mandrake Linux 8.3 (Cooker) for i586
gcc (GCC) 3.1.1 (Mandrake Linux 8.3 3.1.1-0.7mdk)
