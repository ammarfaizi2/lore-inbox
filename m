Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135186AbRDVC6M>; Sat, 21 Apr 2001 22:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135183AbRDVC5X>; Sat, 21 Apr 2001 22:57:23 -0400
Received: from chac.inf.utfsm.cl ([200.1.19.54]:54532 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S135182AbRDVC5P>;
	Sat, 21 Apr 2001 22:57:15 -0400
Message-Id: <200104220256.f3M2ulcL023627@sleipnir.valparaiso.cl>
To: "Eric S. Raymond" <esr@thyrsus.com>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Request for comment -- a better attribution system 
In-Reply-To: Message from "Eric S. Raymond" <esr@thyrsus.com> 
   of "Sat, 21 Apr 2001 16:29:47 -0400." <20010421162947.A4490@thyrsus.com> 
Date: Sat, 21 Apr 2001 22:56:47 -0400
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" <esr@thyrsus.com> said:
> Subject: Re: Request for comment -- a better attribution system
> 
> Return-Path: linux-kernel-owner@vger.kernel.org
> Delivery-Date: Sat Apr 21 20:28:52 2001
> Return-Path: <linux-kernel-owner@vger.kernel.org>
> Reply-To: esr@thyrsus.com
> Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
> 	 "Albert D. Cahalan" <acahalan@cs.uml.edu>,
> 	 CML2 <linux-kernel@vger.kernel.org>,
> 	 kbuild-devel@lists.sourceforge.net
> References: <20010421114942.A26415@thyrsus.com> <200104212023.f3LKN7P188973@sat
>      ***urn.cs.uml.edu>
> Mime-Version: 1.0
> Content-Disposition: inline
> User-Agent: Mutt/1.2.5i
> In-Reply-To: <200104212023.f3LKN7P188973@saturn.cs.uml.edu>; from acahalan@cs.u
>      ***ml.edu on Sat, Apr 21, 2001 at 04:23:06PM -0400
> Organization: Eric Conspiracy Secret Labs
> X-Eric-Conspiracy: There is no conspiracy
> Sender:  linux-kernel-owner@vger.kernel.org
> Precedence: bulk
> X-Mailing-List: linux-kernel@vger.kernel.org
> 
> Albert D. Cahalan <acahalan@cs.uml.edu>:

[...]

> > It is nice to have a single file for grep. With the proposed
> > changes one would sometimes need to grep every file.

> The right way to handle that is to have a report generator that does the
> grep for you, or if you like simply returns the concatenation of all the
> map blocks so you can grep that.

Please, _no_ specialized-just-for-linux-kernel-hacking tools! Unix is great
because it has _no_ such for-one-task-only tools, which you have to learn
how to use each time a reason for using them comes around.
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
