Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312997AbSDOGJU>; Mon, 15 Apr 2002 02:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312998AbSDOGJT>; Mon, 15 Apr 2002 02:09:19 -0400
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:7955 "HELO
	ns.higherplane.net") by vger.kernel.org with SMTP
	id <S312997AbSDOGJT>; Mon, 15 Apr 2002 02:09:19 -0400
Date: Mon, 15 Apr 2002 16:10:31 +1000
From: john slee <indigoid@higherplane.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Memory Leaking. Help!
Message-ID: <20020415061031.GN11940@higherplane.net>
In-Reply-To: <E16wu4J-00057Y-00@the-village.bc.nu> <Pine.LNX.4.33.0204151017480.20961-100000@dipole.es.usyd.edu.au> <20020415011834.B16804@pizzashack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2002 at 01:18:34AM -0400, xystrus wrote:
> On Mon, Apr 15, 2002 at 10:28:00AM +1000, ivan wrote:
> > That was 4 GB not 2.
> > 
> >  No, I do not. That is why I asked is there a way to find out what is 
> > eating ram. I am not sure if this a leakage. I am only a paranoid 
> > sysadmin. 
> > 
> 
> I think you said this was a server, didn't you?
> 
> You neglected to mention that you're running X and Nautilus on this
> server.  You probably don't need this stuff running on a server, and
> it is chewing up a good amount of RAM.  If you don't absolutely need
> X, try bringing the system up in run level 3 and see if your problem
> disappears...

it could be a server for x11-based thin clients

-- 
R N G G   "Well, there it goes again... And we just sit 
 I G G G   here without opposable thumbs." -- gary larson
