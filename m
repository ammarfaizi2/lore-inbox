Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270686AbTHAHMy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 03:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275074AbTHAHMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 03:12:54 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:56583 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270686AbTHAHMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 03:12:51 -0400
Date: Fri, 1 Aug 2003 04:13:25 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: Pawel Kot <pkot@linuxnews.pl>
Cc: szepe@pinerecords.com, kaos@ocs.com.au, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: module-init-tools don't support gzipped modules.
Message-Id: <20030801041325.2f350944.vmlinuz386@yahoo.com.ar>
In-Reply-To: <Pine.LNX.4.33.0307311149110.11927-100000@urtica.linuxnews.pl>
References: <20030731091909.GK12849@louise.pinerecords.com>
	<Pine.LNX.4.33.0307311149110.11927-100000@urtica.linuxnews.pl>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jul 2003 11:52:28 +0200 (CEST), Pawel Kot wrote:
>On Thu, 31 Jul 2003, Tomas Szepe wrote:
>
>> > [kaos@ocs.com.au]
>> >
>> > On Thu, 31 Jul 2003 02:46:23 +1000,
>> > Rusty Russell <rusty@rustcorp.com.au> wrote:
>> > >I don't want to require zlib, though.  The modutils I have
>(Debian)> > >doesn't support it, either.
>> >
>> > Really?  modutils 2.4: ./configure --enable-zlib
>>
>> Keith, I believe Rusty meant the standard Debian package had binaries
>> compiled w/o '--enable-zlib'.
>>
>> (And so has Slackware btw.)
>
>Slackware since 8.0 uses compression for the kernel modules by
>default and uses --enable-zlib for modutils.
>See:
>ftp://ftp.slackware.com/pub/slackware/slackware-9.0/source/a/modutils/
>modutils.SlackBuild

yes, originally I wrote the mail, commenting on the necessity of gzip,
because of mails that interchanges with Patrick Volkerding about the
inclusion of 2.6.


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
