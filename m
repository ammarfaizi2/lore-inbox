Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129855AbQLEAKK>; Mon, 4 Dec 2000 19:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129547AbQLEAKA>; Mon, 4 Dec 2000 19:10:00 -0500
Received: from Cantor.suse.de ([194.112.123.193]:39953 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129855AbQLEAJ5>;
	Mon, 4 Dec 2000 19:09:57 -0500
Date: Tue, 5 Dec 2000 00:39:29 +0100
From: Andi Kleen <ak@suse.de>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: PM in 2.2
Message-ID: <20001205003929.A28879@gruyere.muc.suse.de>
In-Reply-To: <20001205001917.A718@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001205001917.A718@werewolf.able.es>; from jamagallon@able.es on Tue, Dec 05, 2000 at 12:19:17AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2000 at 12:19:17AM +0100, J . A . Magallon wrote:
> Hi everyone.
> 
> I would like to know if there is any back-port of ACPI to 2.2.
> Problem: 2-way machine, so APM does not work.
> I would love my box powers down when I shutdown...just like macs.

Make sure APM is compiled in and put append="apm=power-off" into your
lilo.conf



-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
