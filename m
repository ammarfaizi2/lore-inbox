Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262798AbVAKPdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262798AbVAKPdN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 10:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262800AbVAKPdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 10:33:13 -0500
Received: from coderock.org ([193.77.147.115]:1474 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262798AbVAKPch (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 10:32:37 -0500
Date: Tue, 11 Jan 2005 16:32:29 +0100
From: Domen Puncer <domen@coderock.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at
Subject: Re: [patch 1/1] list_for_each_entry: fs-dquot.c
Message-ID: <20050111153229.GG4978@nd47.coderock.org>
References: <20050110184218.405431F1ED@trashy.coderock.org> <20050111143414.GF15061@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050111143414.GF15061@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/05 15:34 +0100, Jan Kara wrote:
>   Hello,
> 
> > Make code more readable with list_for_each_entry_safe.
> > (Didn't compile before, doesn't compile now)
>   What do you mean by "didn't compile before"? Which kernel have you
> tried?

It seems like it was compile tested with quotas disabled.
It compiles fine when i enable quotas, duh.
Sorry.


	Domen
