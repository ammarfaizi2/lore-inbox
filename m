Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWGPRr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWGPRr6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 13:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWGPRr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 13:47:58 -0400
Received: from thunk.org ([69.25.196.29]:32650 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751104AbWGPRr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 13:47:57 -0400
Date: Sun, 16 Jul 2006 13:48:04 -0400
From: Theodore Tso <tytso@mit.edu>
To: Lexington Luthor <Lexington.Luthor@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiserFS?
Message-ID: <20060716174804.GA23114@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Lexington Luthor <Lexington.Luthor@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20060716161631.GA29437@httrack.com> <20060716162831.GB22562@zeus.uziel.local> <20060716165648.GB6643@thunk.org> <e9dsrg$jr1$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9dsrg$jr1$1@sea.gmane.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2006 at 06:26:03PM +0100, Lexington Luthor wrote:
> I read the archives, and most of the problems pointed out during the 
> review were fixed relatively quickly, followed by a flame war due to 
> some suggesting that reiser4 should not be able to affect VFS semantics, 
> and other such matters (which IMO should be outside of the scope of a 
> code review). There has been no follow-up review as far as I can tell. 

As far as I know not all of the problems were fixed.  And it has been
observed that given the abuse and accusations that were directed at
the people who did decide to review it, that it would not at all
surprising if some (all?) of reviewers may have decided they had
better things to do.  Getting things merged into mainline is not a
right, and the reviewers are volunteers.....

Speaking for myself, since I don't enjoy being accused of partisanship
and being ascribed of having a desire to backstab reiserfs, I have a
personal policy to avoid reiserfs review, and recuse myself from any
votes within program committee discussions regarding Hans Reiser.
Being accused of taking unfair advantage of my volunteer activities is
something I allow myself to get into once.

						- Ted
