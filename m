Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbUJXPli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbUJXPli (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 11:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUJXPlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 11:41:37 -0400
Received: from jade.aracnet.com ([216.99.193.136]:924 "EHLO jade.spiritone.com")
	by vger.kernel.org with ESMTP id S261520AbUJXPlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 11:41:13 -0400
Date: Sun, 24 Oct 2004 08:40:52 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Christoph Hellwig <hch@infradead.org>, Jean Delvare <khali@linux-fr.org>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: bkbits - "@" question
Message-ID: <245810000.1098632450@[10.10.2.4]>
In-Reply-To: <20041023102131.GA30449@infradead.org>
References: <2SmNe-6MO-1@gated-at.bofh.it> <2SqR0-10Q-9@gated-at.bofh.it> <20041023121452.1e82a758.khali@linux-fr.org> <20041023102131.GA30449@infradead.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Christoph Hellwig <hch@infradead.org> wrote (on Saturday, October 23, 2004 11:21:31 +0100):

> On Sat, Oct 23, 2004 at 12:14:52PM +0200, Jean Delvare wrote:
>> > * Larry McVoy asked:
>> > The web pages on bkbits.net contain email addresses.  This is
>> > probably about a 4 year too late question but would it help reduce
>> > spam if we did something like  s/@/ (at) / for all those addresses?
>> > 
>> > * Christoph Hellwig answered:
>> > No.
>> 
>> Why not, please?
> 
> Because spambots parse all this replacements anyway, and it makes cut & pasting
> mail addresses if you want to reply to a change much easier.

Besides which, 99.99% of people who's name appears in the changelogs
have presumably posted to linux-kernel anyway, and are thus in need
of spam prophylactics whatever you do. So it won't help ...

M.

