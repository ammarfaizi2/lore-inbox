Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261650AbSIXLfk>; Tue, 24 Sep 2002 07:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261652AbSIXLfk>; Tue, 24 Sep 2002 07:35:40 -0400
Received: from ns.suse.de ([213.95.15.193]:60423 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261650AbSIXLfj>;
	Tue, 24 Sep 2002 07:35:39 -0400
Date: Tue, 24 Sep 2002 13:40:48 +0200
From: Andi Kleen <ak@suse.de>
To: john slee <indigoid@higherplane.net>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] LTT for 2.5.38 1/9: Core infrastructure
Message-ID: <20020924134048.A25317@wotan.suse.de>
References: <Pine.LNX.4.44.0209221830400.8911-100000@serv.suse.lists.linux.kernel> <Pine.LNX.4.44.0209221130060.1455-100000@home.transmeta.com.suse.lists.linux.kernel> <p734rchu8ny.fsf@oldwotan.suse.de> <20020924010758.GB6675@higherplane.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020924010758.GB6675@higherplane.net>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2002 at 11:07:59AM +1000, john slee wrote:
> On Sun, Sep 22, 2002 at 09:27:29PM +0200, Andi Kleen wrote:
> > There is an old patch around from SGI that does exactly this. It is a
> > very lightweight binary value tracer that has per CPU buffers. It
> > traces using macros that you can easily add. It's called ktrace (not
> > to be confused with Ingo's ktrace). I've been porting it for some time
> 
> and different again from *bsd ktrace?

Yes, of course. 

-Andi
