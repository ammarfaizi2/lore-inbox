Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262241AbSIPOlJ>; Mon, 16 Sep 2002 10:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262242AbSIPOlJ>; Mon, 16 Sep 2002 10:41:09 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:25536 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S262241AbSIPOlI>;
	Mon, 16 Sep 2002 10:41:08 -0400
Message-ID: <1032187563.3d85eeabbdf77@kolivas.net>
Date: Tue, 17 Sep 2002 00:46:03 +1000
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Subject: contest v0.30
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I've updated the "contest" responsiveness benchmark with many code cleanups by
Rik Van Riel, and a more comprehensive readme. The actual benchmarks have not
changed from v0.22 onwards. Previous versions were all slightly different
because of bugs in the code. You can compare like with like from now on. Please
don't use this to compare different hardware; it is unhelpful and the results
will only confuse. Use it to compare kernels on the same hardware. I guess it
could be used to compare filesystems (eg ext3 v reiser) with respect to the
system maintaining responsiveness, but noone's attempted that yet. If anyone's
got any other novel uses I'd love to hear them.

It now has a homepage:
http://contest.kolivas.net

Please feel free to send me any comments, questions, suggestions
Con Kolivas
