Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272696AbRHaOMj>; Fri, 31 Aug 2001 10:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272700AbRHaOMa>; Fri, 31 Aug 2001 10:12:30 -0400
Received: from relay1.zonnet.nl ([62.58.50.37]:31192 "EHLO relay1.zonnet.nl")
	by vger.kernel.org with ESMTP id <S272696AbRHaOMN>;
	Fri, 31 Aug 2001 10:12:13 -0400
Message-ID: <3B8F9B48.80F513AA@linux-m68k.org>
Date: Fri, 31 Aug 2001 16:12:24 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: ptb@it.uc3m.es
CC: "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <200108311329.PAA12559@nbd.it.uc3m.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"Peter T. Breuer" wrote:

> As I said, nobody has been too precise about the bugs to me either!

So let's be precise first! Please?
I've asked Linus about examples, so far I've seen only buggy
implementations of min() or an example, where min() shouldn't be used in
first place. Maybe I missed something, then I'm deeply sorry for this,
but all I want to know is, what are we fixing here?

> Stanford checker? Is that a programmable C type checker? If so, lemmee
> at it. Have you a URL, btw?

http://verify.stanford.edu/SVC/
You should search the archive to look for some good examples, how it can
help.

bye, Roman
