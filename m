Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267503AbTAXBh5>; Thu, 23 Jan 2003 20:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267499AbTAXBh5>; Thu, 23 Jan 2003 20:37:57 -0500
Received: from adsl-67-64-81-217.dsl.austtx.swbell.net ([67.64.81.217]:12718
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S267503AbTAXBh4>; Thu, 23 Jan 2003 20:37:56 -0500
Subject: Re: Problem with Qlogic 2200 and 2.4.20
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: Paul Jakma <paulj@alphyra.ie>
Cc: Thomas Tonino <ttonino@users.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0301231851080.31406-100000@dunlop.admin.ie.alphyra.com>
References: <Pine.LNX.4.44.0301231851080.31406-100000@dunlop.admin.ie.alphyra.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1043372733.12893.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 23 Jan 2003 19:45:33 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-23 at 12:52, Paul Jakma wrote:
> On 23 Jan 2003, GrandMasterLee wrote:
> 
> > Just to chime in, are you using the qlogicfc driver that comes with
> > the kernel? If so, Try using qlogic's 6.01 driver set instead and
> > see if your problem goes away. I've had other problems, mostly stack
> > related, but I've since found my fixes
> 
> hmm.. i'd be very interested in them. I have found the qlogic v6 
> driver to dreadfully unstable under heavy load (eg multiple 
> bonnie++'s) on SMP.

I think you'll have to qualify that with hardware type etc. As for the
6.x driver versions, so far, no instability, except when in beta, was
noticed. My DBs are 1TB and greater and we load very much data into them
every day. Few hundred MB/day. Some get's reconciled away somewhere and
some is trash which is later disposed of, but they never stop loading.
It's a pretty High load I'd say, could be higher though.


> > GrandMasterLee
> 
> regards,
