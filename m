Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266835AbUJWKWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266835AbUJWKWK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 06:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266585AbUJWKWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 06:22:09 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:36875 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266505AbUJWKVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 06:21:39 -0400
Date: Sat, 23 Oct 2004 11:21:31 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: bkbits - "@" question
Message-ID: <20041023102131.GA30449@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jean Delvare <khali@linux-fr.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <2SmNe-6MO-1@gated-at.bofh.it> <2SqR0-10Q-9@gated-at.bofh.it> <20041023121452.1e82a758.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041023121452.1e82a758.khali@linux-fr.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2004 at 12:14:52PM +0200, Jean Delvare wrote:
> > * Larry McVoy asked:
> > The web pages on bkbits.net contain email addresses.  This is
> > probably about a 4 year too late question but would it help reduce
> > spam if we did something like  s/@/ (at) / for all those addresses?
> >
> > * Christoph Hellwig answered:
> > No.
> 
> Why not, please?

Because spambots parse all this replacements anyway, and it makes cut & pasting
mail addresses if you want to reply to a change much easier.

p.s. please reply to me if you reply to my mails, thanks

