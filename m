Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262266AbTANK1B>; Tue, 14 Jan 2003 05:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262296AbTANK1B>; Tue, 14 Jan 2003 05:27:01 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:57860 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S262266AbTANK1A>; Tue, 14 Jan 2003 05:27:00 -0500
Message-ID: <3E23E82E.26E1833A@aitel.hist.no>
Date: Tue, 14 Jan 2003 11:36:30 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.5.55 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Alexander Kellett <lypanov@kde.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: any chance of 2.6.0-test*? -> goto example
References: <Pine.LNX.4.44.0301121208020.14031-100000@home.transmeta.com> <1042404503.1208.95.camel@RobsPC.RobertWilkens.com> <20030112224829.GA29534@alpha.home.local> <1042419236.3162.257.camel@RobsPC.RobertWilkens.com> <20030113013133.GA31596@alpha.home.local> <20030113161045.GA19270@groucho.verza.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Kellett wrote:
[...]
> As much as I absolutely love the utility of this
> piece of code you really do have to admit that it
> _is_ rather difficult to understand :)
> 
It is hard for everybody - until we get used to it.  Then it
is just another normal thing. :-)

> Is it so flawed of me to expect that some day this
> code could be rewritten in an extremely clean
> fashion and compilers made to do the work that
> was put in to make this fast?

This is not flawed - but we actually need that compiler
to exist, and become _common_ before replacing
hand-optimizations with clean code.  Feel free to join
the gcc team and make the world better...

Helge Hafting
