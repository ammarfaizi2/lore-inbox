Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbTDEBKy (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 20:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbTDEBKy (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 20:10:54 -0500
Received: from jalon.able.es ([212.97.163.2]:62865 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id S261623AbTDEBKw (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 20:10:52 -0500
Date: Sat, 5 Apr 2003 03:22:16 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] AT_PLATFORM on HT-P4
Message-ID: <20030405012216.GA3318@werewolf.able.es>
References: <Pine.LNX.4.53L.0304041815110.32674@freak.distro.conectiva> <20030405004327.GA11141@werewolf.able.es> <20030405005020.GA11904@werewolf.able.es> <20030404201839.A21819@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030404201839.A21819@redhat.com>; from bcrl@redhat.com on Sat, Apr 05, 2003 at 03:18:39 +0200
X-Mailer: Balsa 2.0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.05, Benjamin LaHaise wrote:
> On Sat, Apr 05, 2003 at 02:50:20AM +0200, J.A. Magallon wrote:
> > This makes P4 Xeon to report correct i686 platform. Without this, > 
> all those people that think its ld.so automatically picks i686 libs
> > are wrong...
> 
> Uhm, why are you posting a really tiny patch as a bzip2 that nobody
can
> read or quote inline?
> 

Sorry, I said it in other post...
I use balsa-cvs as mailer, and I have just discovered that it wraps
the mail body at 72 columns even if I say it to don't do any wrapping.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is
like sex:
werewolf.able.es                         \           It's better when
it's free
Mandrake Linux release 9.2 (Bamboo) for i586
Linux 2.4.21-pre7-jam1 (gcc 3.2.2 (Mandrake Linux 9.2 3.2.2-5mdk))
