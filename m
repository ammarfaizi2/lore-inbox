Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267544AbTAXEqO>; Thu, 23 Jan 2003 23:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267542AbTAXEqO>; Thu, 23 Jan 2003 23:46:14 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:42504 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S267541AbTAXEqN>; Thu, 23 Jan 2003 23:46:13 -0500
Date: Thu, 23 Jan 2003 21:54:37 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: "David S. Miller" <davem@redhat.com>
cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
       marcelo@conectiva.com.br
Subject: Re: Aic7xxx 6.2.28 and Aic79xx 1.3.0 Released
Message-ID: <756820000.1043384077@aslan.scsiguy.com>
In-Reply-To: <20030123.202727.102788332.davem@redhat.com>
References: <694670000.1043380598@aslan.scsiguy.com>
 	<20030123.195327.107011605.davem@redhat.com>
 	<739810000.1043382396@aslan.scsiguy.com>
 <20030123.202727.102788332.davem@redhat.com>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And in fact, you are describing exactly what Linus and Marcelo's
> jobs are, to reject bogus/broken changes.

I think you missed the subtely of what I said.  It's not "their duty"
to never make a mistake, and it is not expected that they will catch
everything.  When they do miss something, or make a mistake you probably
tell them in a straight forward fashion.  In this case, what you
effectively said to me was:

	"Hey.  I would appreciate it if you would stop not
	 noticing this change that I made to your code through
	 Linus without telling you. *Twice* no less.  Wake up!
	 Wasn't it obvious?  It is *your duty* to notice these
	 one line changes that happen to break the build on
	 a platform that I care about but doesn't have any
	 consequences on the platforms you are probably testing.
	 Oh, and the aic79xx driver... well I didn't bother to
	 look at that because it's not in my configuration.
	 Oh well."

And I get all of this grief *after* I already included the change
instead of after the first time I missed it.  You really make me
laugh!

--
Justin

