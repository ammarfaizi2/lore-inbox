Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262394AbSKTTkv>; Wed, 20 Nov 2002 14:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262448AbSKTTkv>; Wed, 20 Nov 2002 14:40:51 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:62422 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S262394AbSKTTku>;
	Wed, 20 Nov 2002 14:40:50 -0500
From: Cort Dougan <cort@fsmlabs.com>
Date: Wed, 20 Nov 2002 12:44:05 -0700
To: Andre Hedrick <andre@linux-ide.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Xavier Bestel <xavier.bestel@free.fr>,
       Mark Mielke <mark@mark.mielke.cc>, Rik van Riel <riel@conectiva.com.br>,
       David McIlwraith <quack@bigpond.net.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: spinlocks, the GPL, and binary-only modules
Message-ID: <20021120124405.C17249@duath.fsmlabs.com>
References: <20021120123145.B17249@duath.fsmlabs.com> <Pine.LNX.4.10.10211201137110.3892-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.10.10211201137110.3892-100000@master.linux-ide.org>; from andre@linux-ide.org on Wed, Nov 20, 2002 at 11:40:47AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

} Well since there is a fork for everything else,  how about a
} business-linux-2.{4,5} fork?
} 
} As a place to make it even harder for the extremist to whine and cry over
} the usages of binary only modules.
} 
} Comments?

Maybe it's best to not add yet another fork.  I just managed to
dis-entangle myself from maintaining some trees and wouldn't wish that on
anyone else.  A single config option that adds -fno-inline wouldn't be
fork-worthy.

As for extremists complaining... I think you'd just give them a target and
a forum rather than quiet them.
