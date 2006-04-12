Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWDLFqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWDLFqL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 01:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbWDLFqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 01:46:11 -0400
Received: from elasmtp-banded.atl.sa.earthlink.net ([209.86.89.70]:29111 "EHLO
	elasmtp-banded.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1750818AbWDLFqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 01:46:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk20050327; d=earthlink.net;
  b=Cwz+dhon/FzOwtI5tCQ9jMOIg09HdjnmgaslmNb4KGqmePKdqA6+b9nip5GtCJP2;
  h=Received:Message-ID:From:To:Cc:References:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Priority:X-MSMail-Priority:X-Mailer:X-MimeOLE:X-ELNK-Trace:X-Originating-IP;
Message-ID: <004101c65df4$5eb71ce0$0225a8c0@Wednesday>
From: "jdow" <jdow@earthlink.net>
To: "Arjan van de Ven" <arjan@infradead.org>, "Mark Lord" <lkml@rtr.ca>
Cc: "Joshua Hudson" <joshudson@gmail.com>,
       "Ramakanth Gunuganti" <rgunugan@yahoo.com>,
       <linux-kernel@vger.kernel.org>
References: <20060411063127.97362.qmail@web54314.mail.yahoo.com> <20060411230642.GV23222@vasa.acc.umu.se> <bda6d13a0604111938j5ece401cid364582fe9d6cf76@mail.gmail.com> <443C716C.1060103@rtr.ca> <1144819887.3089.0.camel@laptopd505.fenrus.org>
Subject: Re: GPL issues
Date: Tue, 11 Apr 2006 22:45:55 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
X-ELNK-Trace: bb89ecdb26a8f9f24d2b10475b57112070bd049b346111769db8aecc8b9e28f53d22eb99cf5c6dcb350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 71.116.162.101
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 2006-04-11 at 23:18 -0400, Mark Lord wrote:
>> Joshua Hudson wrote:
>> > On 4/11/06, David Weinehall <tao@acc.umu.se> wrote:
>> >> OK, simplified rules; if you follow them you should generally be OK:
>> ..
>> >> 3. Userspace code that uses interfaces that was not exposed to userspace
>> >> before you change the kernel --> GPL (but don't do it; there's almost
>> >> always a reason why an interface is not exported to userspace)
>> >>
>> >> 4. Userspace code that only uses existing interfaces --> choose
>> >> license yourself (but of course, GPL would be nice...)
>> 
>> Err.. there is ZERO difference between situations 3 and 4.
>> Userspace code can be any license one wants, regardless of where
>> or when or how the syscalls are added to the kernel.
> 
> that is not so clear if the syscalls were added exclusively for this
> application by the authors of the application....

Consider a book. The book is GPLed. I do not have to GPL my brain when
I read the book.

I add some margin notes to the GPLed book. I still do not have to GPL
my brain when I read the book.

{^_^}   Joanne Dow
