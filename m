Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVF1T65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVF1T65 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 15:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVF1T6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 15:58:52 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:10473 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261256AbVF1T4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 15:56:35 -0400
Date: Tue, 28 Jun 2005 12:56:33 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
Message-ID: <20050628195633.GA26131@smtp.west.cox.net>
References: <20050624081808.GA26174@kroah.com> <9EE4350F-5791-4787-950B-14E5C2B9ADB8@mac.com> <20050628074145.GC3577@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050628074145.GC3577@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 12:41:45AM -0700, Greg KH wrote:
> On Fri, Jun 24, 2005 at 08:57:55PM -0400, Kyle Moffett wrote:
> > One of the things that most annoys me about udev is that I still need
> > a minimal static dev in order for the system to boot.
> 
> Why?  You should not.  Works just fine for me here :)

Er, don't you need /dev/console for console output to happen? (And that
it's a good idea to have /dev/null around too).  Or has that changed?

-- 
Tom Rini
http://gate.crashing.org/~trini/
