Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbTIYT22 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 15:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbTIYT22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 15:28:28 -0400
Received: from codepoet.org ([166.70.99.138]:5524 "EHLO mail.codepoet.org")
	by vger.kernel.org with ESMTP id S261820AbTIYT20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 15:28:26 -0400
Date: Thu, 25 Sep 2003 13:28:21 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Christoph Hellwig <hch@infradead.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: log-buf-len dynamic
Message-ID: <20030925192821.GA28172@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Matthew Wilcox <willy@debian.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
	Larry McVoy <lm@bitmover.com>
References: <Pine.LNX.4.44.0309231924540.27467-100000@home.osdl.org> <m1n0csiybu.fsf@ebiederm.dsl.xmission.com> <20030925183149.A19774@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030925183149.A19774@infradead.org>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Sep 25, 2003 at 06:31:49PM +0100, Christoph Hellwig wrote:
> Stupid argument.  E.g. the ppc folks used BK much longer than Linus.
> And there are kernel projects using svn (ieee1394) or cvs that you
> can't access without installing svn or cvs.

I use the 'cvsweb' interface to track the ieee1394 codebase.  I
can download specific patches, and anytime I feel like it, it
will automagically generate a current tarball for me.  Therefore,
I can easily track it without needing to use svn (which I do
not have installed).

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
