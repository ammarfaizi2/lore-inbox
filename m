Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265939AbSKOJfY>; Fri, 15 Nov 2002 04:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265960AbSKOJfY>; Fri, 15 Nov 2002 04:35:24 -0500
Received: from gate.in-addr.de ([212.8.193.158]:20755 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S265939AbSKOJfX>;
	Fri, 15 Nov 2002 04:35:23 -0500
Date: Fri, 15 Nov 2002 10:40:51 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
Message-ID: <20021115094051.GF45@marowsky-bree.de>
References: <1037325839.13735.4.camel@rth.ninka.net> <396026666.1037298946@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <396026666.1037298946@[10.10.2.3]>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-11-14T18:35:47,
   "Martin J. Bligh" <mbligh@aracnet.com> said:

> Hmmm ... I'm not sure that being that restrictive is going to help.
> Whilst bugs against any randomly patched version of the kernel
> probably aren't that interesting, things in major trees like -mm, 
> -ac, -dj etc are likely going to end up in mainline sooner or later
> anyway ... wouldn't you rather know of the breakage sooner rather
> than later?

Simple answer:

Bugreports in specific patchsets / kernel trees should first be sent to the
respective maintainer (mailing list, real person, distributor, whatever) and
then be "filtered" by that person into the consolidated "vanilla" bugzilla.

Anything else is madness. (Anything else also won't fit into the support
models of RH, SuSE, UL ...)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Principal Squirrel 
SuSE Labs - Research & Development, SuSE Linux AG
  
"If anything can go wrong, it will." "Chance favors the prepared (mind)."
  -- Capt. Edward A. Murphy            -- Louis Pasteur
