Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262280AbVAEJUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbVAEJUe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 04:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVAEJUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 04:20:34 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:27065 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S262280AbVAEJUL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 04:20:11 -0500
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>,
       Erik Mouw <erik@harddisk-recovery.com>, Adrian Bunk <bunk@stusta.de>,
       Domen Puncer <domen@coderock.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] maintainers: remove moderated arm list
References: <20041225170825.GA31577@nd47.coderock.org>
	<20041225172155.A26504@flint.arm.linux.org.uk>
	<20050103175438.GL2980@stusta.de>
	<20050104085437.GA26584@harddisk-recovery.com>
	<20050104090057.GA2035@infradead.org>
	<20050104092515.B9409@flint.arm.linux.org.uk>
	<20050104093326.GA2408@infradead.org>
	<20050104101921.C9409@flint.arm.linux.org.uk>
From: Jes Sorensen <jes@wildopensource.com>
Date: 05 Jan 2005 04:20:07 -0500
In-Reply-To: <20050104101921.C9409@flint.arm.linux.org.uk>
Message-ID: <yq0brc4kzaw.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Russell" == Russell King <rmk+lkml@arm.linux.org.uk> writes:

Russell> On Tue, Jan 04, 2005 at 09:33:26AM +0000, Christoph Hellwig
Russell> wrote:
>> On Tue, Jan 04, 2005 at 09:25:15AM +0000, Russell King wrote: > In
>> that case, you can personally choose not to send mail there
>> anymore.  > It's completely up to you.  No one is forcing you to
>> send email to any > address.
>> 
>> I don't plan to force anyone to do anything with their
>> mailinglists.  But we shouldn't mention lists with stupid policies
>> as maintainer contacts.

Russell> As Alan has already pointed out, there's more to the
Russell> MAINTAINERS file than just pointing out to main line kernel
Russell> developers where to send their patches.

Maybe it's time to have an additional entry in MAINTAINERS then -
having fscked up lists listed in there equal to sane ones seems
completely inappropriate. Requiring broken lists to marked as 'this
list is b0rked, use it at your own leisure'. That would save users and
developers from having to deal with the side effects of these fscked
up lists.

Using your own argument, I don't care why a list is fscked, the fact
is it's fscked and I don't want to have to waste my time on it.

Cheers,
Jes
