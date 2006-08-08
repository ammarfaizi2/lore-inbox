Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965056AbWHHVmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbWHHVmu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 17:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965058AbWHHVmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 17:42:50 -0400
Received: from elasmtp-banded.atl.sa.earthlink.net ([209.86.89.70]:25749 "EHLO
	elasmtp-banded.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S965056AbWHHVmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 17:42:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk20050327; d=earthlink.net;
  b=KKEcU/hHSP5YJ8t4IM+vtcZGRhqTAHqlCC6F2V1FgQQOmQQVR0DL9dTjQvGDRo/H;
  h=Received:Message-ID:From:To:References:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Priority:X-MSMail-Priority:X-Mailer:X-MimeOLE:X-ELNK-Trace:X-Originating-IP;
Message-ID: <04b101c6bb33$9131bd00$0225a8c0@Wednesday>
From: "jdow" <jdow@earthlink.net>
To: <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <MDEHLPKNGKAHNMBLJOLKIECNNKAB.davids@webmaster.com>
Subject: Re: Time to forbid non-subscribers from posting to the list?
Date: Tue, 8 Aug 2006 14:42:29 -0700
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
X-ELNK-Trace: bb89ecdb26a8f9f24d2b10475b571120e26356c0b0470470ae87f3927ef6ae3b547562a158a8cca8350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 71.116.182.36
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David Schwartz" <davids@webmaster.com>
> 
>> The kernel developers who need to keep the barrier to bug reports low
>> like the current policy.
>>
>> Get a good spam filter, I only get 1-2 pieces a day in my LKML folder.
>>
>> Jeff
> 
> How is everyone individually spam filtering better than one central spam
> filter? More likelihood that at least one relevent person will get the bug
> report? Certainly a single central spam filter can get more resources aimed
> at it to make sure it doesn't suppress anything important.

If you have the luxury of the ability to write personalized rules and
whitelist entries for SpamAssassin it can become a startlingly good
filtering system. And you can tailor the filtering for individual 
sources with meta rules. Processing large numbers of messages through
BAYES and large numbers of rules gets quite time consuming, perhaps
more than vger might want to handle. Processing only a small number
of email accounts for trustworthy people allows one the luxury of
custom rules and individual BAYES filtering. Since a lot of what
one person might consider to be spam is another person's ham this is
a good thing. (And SURBL is a good thing, too. It is remarkably
reliable as long as you're not one of the first receiving a particular
piece of junk. The SpamAssassin "RulesEmporium" has some very nice
anti-spam rule sets, too.)

{^_^}   Joanne
