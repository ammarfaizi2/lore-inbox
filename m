Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314325AbSFTNF3>; Thu, 20 Jun 2002 09:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314340AbSFTNF2>; Thu, 20 Jun 2002 09:05:28 -0400
Received: from jalon.able.es ([212.97.163.2]:22671 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S314325AbSFTNF1>;
	Thu, 20 Jun 2002 09:05:27 -0400
Date: Thu, 20 Jun 2002 15:05:11 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre10aa3
Message-ID: <20020620130511.GA8426@werewolf.able.es>
References: <20020620055933.GA1308@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020620055933.GA1308@dualathlon.random>; from andrea@suse.de on Thu, Jun 20, 2002 at 07:59:33 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.06.20 Andrea Arcangeli wrote:
>
>Only in 2.4.19pre10aa3: 07_e100-1.8.38.gz
>Only in 2.4.19pre10aa3: 08_e100-includes-1
>Only in 2.4.19pre10aa3: 09_e100-compilehack-1
>
>	Merged e100 GPL driver from Intel (also make it link
>	into the kernel).
>

???

Current driver is 2.0.30...
And would not have been easier to get it from 2.5 ? You just have
good Makefiles, instead of hacking those from Intel, that I suppose
are prepared for building separate from kernel tree.

Or just take it from jam2...I have been using both e100 and e1000
in the same cluster and no problem with them.

Btw, would you mind mergin also e1000...? ;).

By.

-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-pre10-jam3, Mandrake Linux 8.3 (Cooker) for i586
gcc (GCC) 3.1.1 (Mandrake Linux 8.3 3.1.1-0.4mdk)
