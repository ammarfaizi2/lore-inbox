Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266354AbSL1Wo3>; Sat, 28 Dec 2002 17:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266356AbSL1Wo3>; Sat, 28 Dec 2002 17:44:29 -0500
Received: from smtp09.iddeo.es ([62.81.186.19]:9619 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S266354AbSL1Wo2>;
	Sat, 28 Dec 2002 17:44:28 -0500
Date: Sat, 28 Dec 2002 23:52:45 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aic7xxx bouncing over 4G
Message-ID: <20021228225245.GA1999@werewolf.able.es>
References: <200212282224.gBSMO5h03843@localhost.localdomain> <837658112.1041114694@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <837658112.1041114694@aslan.scsiguy.com>; from gibbs@scsiguy.com on Sat, Dec 28, 2002 at 23:31:34 +0100
X-Mailer: Balsa 2.0.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.12.28 Justin T. Gibbs wrote:
> > gibbs@scsiguy.com said:
> >> Hmm.  The only previous bug report I had in this area was related to a
> >> missing cast.  That was fixed, but I guess it wasn't enough to solve
> >> the problem. 
> > 
> > It looks like possibly a config option that doesn't exist
> 
> Yes.  It seems to only exist in 2.4.X.  I'll have to use a different
> method for toggling the highmem_io option in the host structure.
> 

Justin, could you write some Configure.help for new options, please ?

TIA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre2-jam1 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-2mdk))
