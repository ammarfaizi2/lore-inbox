Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310979AbSC1Aby>; Wed, 27 Mar 2002 19:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311026AbSC1Abp>; Wed, 27 Mar 2002 19:31:45 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:13145 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S310979AbSC1Abh>; Wed, 27 Mar 2002 19:31:37 -0500
Date: Wed, 27 Mar 2002 19:31:26 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Erik Andersen <andersen@codepoet.org>, Jos Hulzink <josh@stack.nl>,
        jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: DE and hot-swap disk caddies
Message-ID: <20020327193126.J29474@redhat.com>
In-Reply-To: <20020328001709.GA16582@codepoet.org> <Pine.LNX.4.10.10203271618550.6006-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2002 at 04:23:34PM -0800, Andre Hedrick wrote:
> There was one company how got it correct, but I do not know if they are
> still around.  The solution is not CHEAP, it requires total HOST vender
> unique callers and special state diagrams.  Also this was a true
> Master/Slave pair solution, the hook was it broke the timing skews on the
> buss. Thus Ultra33 or mode 2 as the limit.

What about the hot swap bays I've picked up that properly handle power 
up/down?  If that is the only device on the bus and the interface is 
properly tristated, what prevents hot swap?

		-ben
-- 
"A man with a bass just walked in,
 and he's putting it down
 on the floor."
