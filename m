Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275074AbTHAHNA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 03:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275121AbTHAHM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 03:12:59 -0400
Received: from smtp013.mail.yahoo.com ([216.136.173.57]:19717 "HELO
	smtp013.mail.yahoo.com") by vger.kernel.org with SMTP
	id S275074AbTHAHM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 03:12:56 -0400
Date: Fri, 1 Aug 2003 04:14:56 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: willy@w.ods.org, linux-kernel@vger.kernel.org
Subject: Re: module-init-tools don't support gzipped modules.
Message-Id: <20030801041456.6ccbcc71.vmlinuz386@yahoo.com.ar>
In-Reply-To: <20030801064916.3F45B2C2B2@lists.samba.org>
References: <20030731143350.GA30865@alpha.home.local>
	<20030801064916.3F45B2C2B2@lists.samba.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Aug 2003 16:30:44 +1000, Rusty Russell wrote:
>In message <20030731143350.GA30865@alpha.home.local> you write:
>> On Thu, Jul 31, 2003 at 11:06:35AM +1000, Keith Owens wrote:
>> > On Thu, 31 Jul 2003 02:46:23 +1000, 
>> > Rusty Russell <rusty@rustcorp.com.au> wrote:
>> > >I don't want to require zlib, though.  The modutils I have
>(Debian)> > >doesn't support it, either.
>> > 
>> > Really?  modutils 2.4: ./configure --enable-zlib
>> 
>> Ok, here is a patch against module-init-tools-0.9.13-pre that I
>ported from> modutils. I haven't tested it yet since I don't have any
>2.6 kernel right here.> But at least it compiles with and without zlib.
>
>OK, I'll work from this patch: I'll probably pull out a separate
>"snarf file" function and use that for all these cases, to ensure
>there's only one #ifdef though.
>
>Thanks!
>Rusty.
>--

Greetings, and thanks a lot for your attention!.

chau, djgera

-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
