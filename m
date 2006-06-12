Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbWFLIXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWFLIXl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 04:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbWFLIXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 04:23:41 -0400
Received: from elasmtp-banded.atl.sa.earthlink.net ([209.86.89.70]:56467 "EHLO
	elasmtp-banded.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1750843AbWFLIXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 04:23:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk20050327; d=earthlink.net;
  b=lHd0pNpXkh+rivE+8N//hJsCg6u3kKjEgtColDc8MZ9SrqM28W8pD+h0sHhtW92d;
  h=Received:Message-ID:From:To:Cc:References:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Priority:X-MSMail-Priority:X-Mailer:X-MimeOLE:X-ELNK-Trace:X-Originating-IP;
Message-ID: <00de01c68df9$7d2b2330$0225a8c0@Wednesday>
From: "jdow" <jdow@earthlink.net>
To: "Bernd Petrovitsch" <bernd@firmix.at>
Cc: <davids@webmaster.com>, <linux-kernel@vger.kernel.org>
References: <MDEHLPKNGKAHNMBLJOLKEEFGMHAB.davids@webmaster.com> <193701c68d16$54cac690$0225a8c0@Wednesday> <1150100286.26402.13.camel@tara.firmix.at>
Subject: Re: VGER does gradual SPF activation (FAQ matter)
Date: Mon, 12 Jun 2006 01:23:30 -0700
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
X-ELNK-Trace: bb89ecdb26a8f9f24d2b10475b571120b56ff735b21b18007566b9149dadb9f5958b41aee76148e9350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 71.116.167.175
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Bernd Petrovitsch" <bernd@firmix.at>

> On Sat, 2006-06-10 at 22:17 -0700, jdow wrote:
> [...]
>> that matter. It simply says, "When I went and looked at the guy's claimed
>> mail source the spf record said he was who he said he was." Who vouches
> 
> No. SPF simply defines legitimate outgoing MTAs for a given domain.
> Within a domain, it is up to the postmaster to allow/disallow address
> forgery and for the rest of a world (to tell where legitimate email of
> his domain comes from), the postmaster defines SPF records.
> 
> Bernd

And just recently we received a spate of spam that came from a domain
that disappeared almost immediately. Domain names are cheap. They can
vouch for the spam run. Then what happens to them doesn't matter. But
the SPF record passes.

{^_-}   There Ain't No Such Thing As A Free Lunch.
        Too many people think SPF is a free lunch.
