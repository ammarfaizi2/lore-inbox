Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272065AbRIEKVn>; Wed, 5 Sep 2001 06:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272071AbRIEKVe>; Wed, 5 Sep 2001 06:21:34 -0400
Received: from adsl-64-175-255-50.dsl.sntc01.pacbell.net ([64.175.255.50]:11457
	"HELO kobayashi.soze.net") by vger.kernel.org with SMTP
	id <S272065AbRIEKV0>; Wed, 5 Sep 2001 06:21:26 -0400
Date: Wed, 5 Sep 2001 03:21:47 -0700 (PDT)
From: Justin Guyett <justin@soze.net>
X-X-Sender: <tyme@kobayashi.soze.net>
To: David Schwartz <davids@webmaster.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.4.9-ac6
In-Reply-To: <NOEJJDACGOHCKNCOGFOMGECJDLAA.davids@webmaster.com>
Message-ID: <Pine.LNX.4.33.0109050259260.17769-100000@kobayashi.soze.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Sep 2001, David Schwartz wrote:

<snip>

So basically this is all obvious.  Nobody's going to help someone with a
million-dollar GPL module if they don't provide the code.  People will
help others with non-GPL modules if they are interested in helping, can
legally get the code, and can legally distribute patches.  Nobody's going
to be an idiot and stick rigidly by a tainting scheme when someone
obviously has an open-source module that's not GPL, and needs help.
That's all I was trying to say.  I don't think everyone's going to
ignore tainted bug reports universally, and there's nothing requiring that
to happen.  It makes sense to read a bit more into a bug report anyway;
Ignoring filesystem corruption because the bug report was tainted by an
nvidia driver or a 3rd-party serial driver isn't going to help anyone.

That's all in the interpretation of the tainted report, not the fact that
it's tainted.  There's also reporter-end probably-undebuggable report
elimination.  If two people a year don't report "X Crashed ... and I use
nvdriver", that's a reason to have a taint flag, even if everyone ignored
the flag, even if it was set, in bug reports that were posted, right?


justin

