Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262433AbREUJ7x>; Mon, 21 May 2001 05:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262438AbREUJ7n>; Mon, 21 May 2001 05:59:43 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:37382 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S262435AbREUJ7c>;
	Mon, 21 May 2001 05:59:32 -0400
To: Jakob =?iso-8859-1?q?=D8stergaard?= <jakob@unthought.net>
Cc: "Robert M. Love" <rml@tech9.net>, John Cowan <jcowan@reutershealth.com>,
        esr@thyrsus.com, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: CML2 design philosophy heads-up
In-Reply-To: <20010505192731.A2374@thyrsus.com> <d33da9tjjw.fsf@lxplus015.cern.ch> <20010513112543.A16121@thyrsus.com> <d3d79awdz3.fsf@lxplus015.cern.ch> <20010515173316.A8308@thyrsus.com> <d3wv7eptuz.fsf@lxplus015.cern.ch> <3B054500.2090408@reutershealth.com> <d31ypj1r4y.fsf@lxplus015.cern.ch> <990411054.773.0.camel@phantasy> <20010521043553.C20911@unthought.net>
From: Jes Sorensen <jes@sunsite.dk>
Date: 21 May 2001 11:58:34 +0200
In-Reply-To: Jakob =?iso-8859-1?q?=D8stergaard's?= message of "Mon, 21 May 2001 04:35:53 +0200"
Message-ID: <d3ofsnowfp.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jakob" == Jakob Østergaard <jakob@unthought.net> writes:

Jakob> On Sun, May 20, 2001 at 10:10:49PM -0400, Robert M. Love wrote:
>> I think this is a very important point, and one I agree with.  I
>> tend to let my distribution handle stuff like python.  now, I use
>> RedHat's on-going devel, RawHide. it is not using python2.  in
>> fact, since switching to python2 may break old stuff, I don't
>> expect python2 until 8.0. that wont be for 9 months.  90% of
>> RedHat's configuration tools, et al, are written in python1 and
>> they just are not going to change on someone's whim.

Jakob> 2.6.0 isn't going to happen for at least a year or two.  What's
Jakob> the problem ?

Jakob> Want 2.5.X ?  Get the tools too.

Some people grab the latest devel kernels because thats all that works
on their hardware.

Jakob> I'm in no position to push people around, but I think the
Jakob> whining about CML2 tool requirements is completely unjustified.
Jakob> If we required that everything worked with GCC 2.7.2 and nmake,
Jakob> where would we be today ?  I'm a lot more worried about CML2
Jakob> itself than about the tools it requires :)

gcc-2.7.2 is broken it miscompiles the kernel, Python1 or bash are
not.

Jakob> Whether CML2 requires python2 or not, the distributions will
Jakob> change. This is not about Eric pushing something down people's
Jakob> throats. Tools evolve, and new revisions introduce
Jakob> incompatibilities, but distributions still follow the
Jakob> evolution.  Nobody ships perl4 today either.

The point is that Eric has been trying to push distributions to ship
P2.

Jes
