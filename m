Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285879AbRLTC4a>; Wed, 19 Dec 2001 21:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285878AbRLTC4U>; Wed, 19 Dec 2001 21:56:20 -0500
Received: from bexfield.research.canon.com.au ([203.12.172.125]:40252 "HELO
	b.mx.canon.com.au") by vger.kernel.org with SMTP id <S285881AbRLTC4J>;
	Wed, 19 Dec 2001 21:56:09 -0500
Date: Thu, 20 Dec 2001 13:52:21 +1100
From: Cameron Simpson <cs@zip.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: billh@tierra.ucsd.edu, bcrl@redhat.com, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: aio
Message-ID: <20011220135221.A23908@zapff.research.canon.com.au>
Reply-To: cs@zip.com.au
In-Reply-To: <20011219171631.A544@burn.ucsd.edu> <20011219.172046.08320763.davem@redhat.com> <20011220133705.A21648@zapff.research.canon.com.au> <20011219.184718.88473152.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011219.184718.88473152.davem@redhat.com>; from davem@redhat.com on Wed, Dec 19, 2001 at 06:47:18PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2001 at 06:47:18PM -0800, David S. Miller <davem@redhat.com> wrote:
|    (Though an attitude like yours is a core reason Java is
|    spreading as slowly as it is - much like Linux desktops...)
| It's actually Sun's fault more than anyone else's.

Debatable. But fortunately off topic.

|    However, heavily threaded apps regardless of language are hardly likely
|    to disappear; threads are the natural way to write many many things. And
|    if the kernel implements threads as on Linux, then the scheduler will
|    become much more important to good performance.
| We are not talking about the scheduler, we are talking about
| AIO.

It was in the same thread - I must have ignored the detail switch. Ignore
me in turn. But while I'm here, tell me why async I/O is important
to Java and not to anything else, which still seems the thrust of your
remarks.
-- 
Cameron Simpson, DoD#743        cs@zip.com.au    http://www.zip.com.au/~cs/

Always code as if the guy who ends up maintaining your code will be a violent
psychopath who knows where you live.
	- Martin Golding, DoD #0236, martin@plaza.ds.adp.com
