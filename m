Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287432AbSAPUHh>; Wed, 16 Jan 2002 15:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287436AbSAPUH1>; Wed, 16 Jan 2002 15:07:27 -0500
Received: from chello212186127068.14.vie.surfer.at ([212.186.127.68]:21420
	"EHLO server.home.at") by vger.kernel.org with ESMTP
	id <S287432AbSAPUHT>; Wed, 16 Jan 2002 15:07:19 -0500
Subject: Re: floating point exception
From: Christian Thalinger <e9625286@student.tuwien.ac.at>
To: Bruce Harada <bruce@ask.ne.jp>
Cc: Dave Jones <davej@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020116221454.12e55709.bruce@ask.ne.jp>
In-Reply-To: <1011181530.513.0.camel@sector17.home.at>
	<Pine.LNX.4.33.0201161257210.9083-100000@Appserv.suse.de> 
	<20020116221454.12e55709.bruce@ask.ne.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 16 Jan 2002 21:06:07 +0100
Message-Id: <1011211577.1617.4.camel@sector17.home.at>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-01-16 at 14:14, Bruce Harada wrote:
> On Wed, 16 Jan 2002 12:58:35 +0100 (CET)
> Dave Jones <davej@suse.de> wrote:
> 
> > On 16 Jan 2002, Christian Thalinger wrote:
> > 
> > > I mentioned in my first mail the dual tyan, so athlon xp, no fpu
> > > emulator ;-) and no oops messages.
> > 
> > Dual Athlon XP problem. Thanks for playing.
> 
> Interesting. That's the first actual report I've seen of problems caused by
> using XPs instead of MPs. I'd been wondering if I could get away with XPs for
> my next SMP box; now I know better ;)

Don't be too scared. Everything works except this seti thingy.

