Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271159AbTG1XBh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 19:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271163AbTG1XBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 19:01:37 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:47882 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S271159AbTG1XBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 19:01:35 -0400
Date: Tue, 29 Jul 2003 01:01:33 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2: cursor started to disappear
Message-ID: <20030728230133.GB1845@win.tue.nl>
References: <20030728181408.GA499@elf.ucw.cz> <20030728182757.GA1793@win.tue.nl> <20030728131741.528a4707.akpm@osdl.org> <20030728203838.GB1815@win.tue.nl> <20030728133431.0a4825ca.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030728133431.0a4825ca.akpm@osdl.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 01:34:31PM -0700, Andrew Morton wrote:

> That's cryptoloop.  I thought you were referring to vanilla loop.
> 
> Are you saying that the problems are only with cryptoloop, or does
> normal old loop have some bug?

It would be too optimistic to claim that it has none,
but the easily provoked corruption I mentioned is for cryptoloop.
Sorry for being imprecise.


