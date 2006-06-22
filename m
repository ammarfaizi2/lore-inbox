Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030408AbWFVV23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030408AbWFVV23 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 17:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932658AbWFVV23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 17:28:29 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63413 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932653AbWFVV22 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 17:28:28 -0400
Date: Thu, 22 Jun 2006 23:28:26 +0200
From: Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: What's in git.git and announcing v1.4.1-rc1
Message-ID: <20060622212826.GG21864@pasky.or.cz>
References: <7v8xnpj7hg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606221301500.5498@g5.osdl.org> <20060622205859.GF21864@pasky.or.cz> <Pine.LNX.4.64.0606221402140.6483@g5.osdl.org> <e7f1pk$l1q$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7f1pk$l1q$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> Isn't manually numbering the enum choices somewhat pointless, though?
> >> (Actually makes it more difficult to do changes in it later.)
> > 
> > Yeah, I just mindlessly followed Johannes' original scheme. 
> 
> You might want to start at 0, just in case...

C99 (6.7.2.2) guarantees the enumeration constants start at 0 if not
specified otherwise.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
