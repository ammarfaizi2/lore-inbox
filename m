Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264305AbTCXRvY>; Mon, 24 Mar 2003 12:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264306AbTCXRvY>; Mon, 24 Mar 2003 12:51:24 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:4481 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264305AbTCXRvX>; Mon, 24 Mar 2003 12:51:23 -0500
Date: Mon, 24 Mar 2003 18:02:18 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: henrique.gobbi@cyclades.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: cyclades region handling updates from 2.4
Message-ID: <20030324180211.GA8300@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	henrique.gobbi@cyclades.com, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <200303241641.h2OGft35008188@deviant.impure.org.uk> <3E7ED5F6.9090301@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E7ED5F6.9090301@cyclades.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 09:55:02AM +0000, Henrique Gobbi wrote:

 > What is this patch for ?

it's a forward port of a set of fixes that already went into 2.4
 
 > How extensively did you test it.

-ENOHARDWARE.

 > This driver is working and I don't wanna it broken. There are too many 
 > customers counting on it.

if you have customers depending on 2.5 right now, you have bigger problems.
Note this is only stuff that has already been merged into 2.4

 > Another thing. Why do you want to put Ivan Passos as the maintainer ? I 
 > talk to him everyday and I know he is not, and he doesn't want to be, 
 > the maintainer of the driver.

Ok, so that part needs updating. Apologies.

		Dave

