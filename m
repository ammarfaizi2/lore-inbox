Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267890AbTBVM45>; Sat, 22 Feb 2003 07:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267891AbTBVM45>; Sat, 22 Feb 2003 07:56:57 -0500
Received: from ce06d.unt0.torres.ka0.zugschlus.de ([212.126.206.6]:19462 "EHLO
	torres.ka0.zugschlus.de") by vger.kernel.org with ESMTP
	id <S267890AbTBVM44>; Sat, 22 Feb 2003 07:56:56 -0500
Date: Sat, 22 Feb 2003 14:07:04 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: linux-kernel@vger.kernel.org
Subject: Re: ethernet-ATM-Router freezing
Message-ID: <20030222130704.GB25040@torres.ka0.zugschlus.de>
References: <20030222084958.GC23827@torres.ka0.zugschlus.de> <1045914526.12534.153.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045914526.12534.153.camel@zion.wanadoo.fr>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2003 at 12:48:46PM +0100, Benjamin Herrenschmidt wrote:
> Your reasoning is wrong. It can well be a HW failure, those can be
> load related in various way (memory failure happening when memory
> is actually used, thermal failure happening on CPU load, etc...)
> 
> If the exact same setup worked for a while with same/similar loads
> and suddenly started to fail, there are great chances it's actually
> HW failure (possibly RAM).

So you think that we have had two machines going bad on us with the
same kind of failure within just a few days?

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Karlsruhe, Germany |  lose things."    Winona Ryder | Fon: *49 721 966 32 15
Nordisch by Nature |  How to make an American Quilt | Fax: *49 721 966 31 29
