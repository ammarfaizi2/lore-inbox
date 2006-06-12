Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751890AbWFLLhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbWFLLhE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 07:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbWFLLhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 07:37:04 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:33420 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1751890AbWFLLhC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 07:37:02 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17549.20672.508670.57631@gargle.gargle.HOWL>
Date: Mon, 12 Jun 2006 15:32:16 +0400
To: David Miller <davem@davemloft.net>
Cc: folkert@vanheusden.com, matti.aarnio@zmailer.org,
       linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation (FAQ matter)
Newsgroups: gmane.linux.kernel
In-Reply-To: <20060611.115430.112290058.davem@davemloft.net>
References: <20060610222734.GZ27502@mea-ext.zmailer.org>
	<20060611160243.GH20700@vanheusden.com>
	<1150048497.14253.140.camel@mindpipe>
	<20060611.115430.112290058.davem@davemloft.net>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller writes:
 > From: Lee Revell <rlrevell@joe-job.com>
 > Date: Sun, 11 Jun 2006 13:54:57 -0400
 > 
 > > On Sun, 2006-06-11 at 18:02 +0200, Folkert van Heusden wrote:
 > > > Hmmm.
 > > > What about using spamhaus.org sbl+xbl list?
 > > > I used to receive 1200 spam messages a day, with spamhaus only half of
 > > > that.
 > > 
 > > What about doing nothing?  The percentage of spam on LKML is vanishingly
 > > small.
 > 
 > We definitely need a better spam solution at vger, the reason is that
 > the current mechanism (ad-hoc by-hand regexp blocking) creates lots of
 > problems.  For one thing, it means that people with names in languages
 > other than english get blocked when their emails are quoted in
 > postings.  This is because we don't understand a lot of languages, so
 > we just regexp block multibyte characters typically assosciated with
 > that language in order to block spam written in that language.
 > 
 > That isn't acceptable in the long term.

Why? So far people managed to transcribe their names into English
alphabet without much trouble (and ado).

Nikita. (see? I do.)
