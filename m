Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbWEUJLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWEUJLm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 05:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWEUJLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 05:11:42 -0400
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:37809 "HELO
	smtp105.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932325AbWEUJLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 05:11:41 -0400
Date: Sun, 21 May 2006 02:11:39 -0700
From: Chris Wedgwood <cw@f00f.org>
To: dragoran <dragoran@feuerpokemon.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IA32 syscall 311 not implemented on x86_64
Message-ID: <20060521091139.GB3468@taniwha.stupidest.org>
References: <44702650.30507@feuerpokemon.de> <20060521085015.GB2535@taniwha.stupidest.org> <44702D92.3050607@feuerpokemon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44702D92.3050607@feuerpokemon.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2006 at 11:06:26AM +0200, dragoran wrote:

> ok but what does this do and what happens to this apps?

my guess is they fallback to something else and still work, but it's
only a guess

> I did but got no reply yet

does it happen with a mainline kernel?  a quick scan of the code shows
that syscall is wired up
