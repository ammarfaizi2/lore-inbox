Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265543AbSKABLX>; Thu, 31 Oct 2002 20:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265546AbSKABLW>; Thu, 31 Oct 2002 20:11:22 -0500
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:24902 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S265543AbSKABLT>; Thu, 31 Oct 2002 20:11:19 -0500
Date: Thu, 31 Oct 2002 17:25:10 -0800 (PST)
From: "Matt D. Robinson" <yakker@aparity.com>
To: Dave Anderson <anderson@redhat.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: [lkcd-devel] Re: What's left over.
In-Reply-To: <3DC199B5.8DDE2FE1@redhat.com>
Message-ID: <Pine.LNX.4.44.0210311720230.23393-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

|>On Thu, 31 Oct 2002, Matt D. Robinson wrote:
|>> We want to see this in the kernel, frankly, because it's a pain
|>> in the butt keeping up with your kernel revisions and everything
|>> else that goes in that changes.  And I'm sure SuSE, UnitedLinux and
|>> (hopefully) Red Hat don't want to spend their time having to roll
|>> this stuff in each and every time you roll a new kernel.
|>
|>While Red Hat advocates Ingo's netdump option, we have customer
|>requests that are requiring us to look at LKCD disk-based dumps as an
|>alternative, co-existing dump mechanism.  Since the two methods are
|>not mutually exclusive, LKCD will never kill off netdump -- nor
|>certainly vice-versa.  We're all just looking for a better means
|>to be able to provide support to our customers, not to mention
|>its value as a development aid.

I think you and I are in agreement (as always has been in the
past), Dave.  LKCD is meant to create a base for disk, network,
or any dump method.  If Red Hat wants netdump to be the primary
dumping method, that's Red Hat's decision, and more power to
them.  If SuSE wants disk dumps, that's SuSE's decision.  But
for both of them to have to roll their own every single release
or kernel upgrade is unproductive.

What's most concerning about this entire discussion is that I
bet < 20% of the people discussing this have actually LOOKED at
the LKCD patches to see whether or not this is as invasive,
difficult, bloated, or anything negative.  We've spent over a
month now posting them, getting comments, responding to all of
the comments, making sure feedback is accounted for and
responded to, only to get an "LKCD is stupid" type response.

--Matt

