Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbVDEOAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbVDEOAd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 10:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVDEOAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 10:00:33 -0400
Received: from smtp10.wanadoo.fr ([193.252.22.21]:24273 "EHLO
	smtp10.wanadoo.fr") by vger.kernel.org with ESMTP id S261735AbVDEOAY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 10:00:24 -0400
X-ME-UUID: 20050405140023268.4195E2400179@mwinf1004.wanadoo.fr
Date: Tue, 5 Apr 2005 15:57:01 +0200
To: Humberto Massa <humberto.massa@almg.gov.br>
Cc: debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050405135701.GA24361@pegasos>
References: <h-GOHD.A.KL.s2aUCB@murphy> <42527E89.4040506@almg.gov.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <42527E89.4040506@almg.gov.br>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 09:03:21AM -0300, Humberto Massa wrote:
> Theodore Ts'o wrote:
> 
> > You know, the fact that Red Hat, SuSE, Ubuntu, and pretty much all
> > other commercial distributions have not been worried about getting
> > sued for this alleged GPL'ed violation makes it a lot harder for me
> > (and others, I'm sure) take Debian's concerns seriously.
> 
> I said in other e-mail, and I will repeat: it's not their (Debian's) 
> fault. Their responsibility is greater. Why? Because when RedHat puts 
> something it shouldn't in their distro it's *their* assets that will 
> answer for some copyright violation damages. In Debian's case, it's the 
> assets of: some DDs, the mirror network, derived-distro distributors, CD 
> vendors, etc... This is just a case of Debian being "fiscally 
> responsible", i.e., not treating other people's money as trash.

This is where you are wrong, and i believe this is caused because you don't
understand how debian works on this.

The ftp-master are the ones reviewing the licencing problems, and they are the
ones handling the infrastructure, and putting their responsability on the
stake. If they feel that some piece of software has dubious legal issues which
come at a risk of having them personally come on the receiving end of a legal
case, then they will say, no, we don't distribute this software, and that is
the end of it.

The other point is that other entities, like redhat, or suse (which is now
novel and thus ibm) and so have stronger backbones, and can more easily muster
the ressources to fight of a legal case, even one which is a dubious one,
especially given the particularities of the US judicial system, where it is
less important to be right, and more important to have lot of money to throw
at your legal machine. Debian has nothing such, and SPI which would stand for
this, is not really upto it either, so in this case, apart from all ideology
and fanatism, it is for purely pragmatic reasons that they don't distribute
undistributable files from the non-free part of our archive. You would do the
same in their case.

Also, you have to ask yourself what the above mentioned companies where to do
if they where to be made aware of the issue, and ask their lawyers to attend
this. Also you have to consider the case of some of those companies ending in
the arms of a legally predative company and pulling another SCO at us.

Friendly,

Sven Luther

