Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750926AbWEVPPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbWEVPPx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 11:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWEVPPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 11:15:53 -0400
Received: from 87-237-56-54.northerncolo.co.uk ([87.237.56.54]:1004 "EHLO
	totally.trollied.org") by vger.kernel.org with ESMTP
	id S1750926AbWEVPPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 11:15:52 -0400
Date: Mon, 22 May 2006 16:15:28 +0100
From: John Levon <levon@movementarian.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, phil.el@wanadoo.fr,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Is OPROFILE actively maintained?
Message-ID: <20060522151528.GA20960@totally.trollied.org>
References: <20060520025322.GD9486@taniwha.stupidest.org> <20060521194915.GA2153@taniwha.stupidest.org> <1148298681.17376.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148298681.17376.23.camel@localhost.localdomain>
X-Url: http://www.movementarian.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2006 at 12:51:21PM +0100, Alan Cox wrote:

> Be serious, oprofile is good working code, even if you have some
> personal problem with it.

Does the opinion of the former mantainer count for nothing? If nothing
else, it should remain experimental on arches like Alpha, where there's
a whole bunch of events that can't possibly work.

regards
john
