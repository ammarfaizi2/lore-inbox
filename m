Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315416AbSHMEnw>; Tue, 13 Aug 2002 00:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315430AbSHMEnv>; Tue, 13 Aug 2002 00:43:51 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:7690 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id <S315416AbSHMEnv>;
	Tue, 13 Aug 2002 00:43:51 -0400
Date: Tue, 13 Aug 2002 06:47:40 +0200
From: Willy Tarreau <willy@w.ods.org>
To: linux-kernel@vger.kernel.org
Subject: Re: TCP/IP connection setup using ECN: interaction with firewall problems
Message-ID: <20020813044740.GA17684@alpha.home.local>
References: <20020813021944.A11951@santana.vm.dabrunz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020813021944.A11951@santana.vm.dabrunz.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 02:19:44AM +0200, Olaf Dabrunz wrote:
 
> I actually experience the first problem stated above. The tpcdump trace
> below shows what happens when I try to connect to www.nvidia.com.

I also incidently noticed that nvidia drops ECN packets the first and only
time I tried to reach their site. IIRC, they also have other problems with
MTU. I think that their drivers are closed source because their developers
are as good as the network administrators, or even the same people :-/

Regards,
Willy
