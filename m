Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbTLENCH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 08:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263985AbTLENCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 08:02:07 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:53737 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263980AbTLENCF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 08:02:05 -0500
Date: Fri, 5 Dec 2003 14:02:02 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: partially encrypted filesystem
Message-ID: <20031205130202.GA31855@wohnheim.fh-wedel.de>
References: <1070485676.4855.16.camel@nucleon> <20031204141725.GC7890@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0312040712270.2055@home.osdl.org> <20031204172653.GA12516@wohnheim.fh-wedel.de> <bqo1a2$s8i$1@abraham.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bqo1a2$s8i$1@abraham.cs.berkeley.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 December 2003 19:18:26 +0000, David Wagner wrote:
> 
> What?  No.  Modern cryptosystems are designed to be secure against
> known plaintext attacks.  Making your system more convoluted merely to
> avoid providing known plaintext is a lousy design approach: the extra
> complexity usually adds more risk than it removes.

All cryptosystems are designed around the hope that noone figures out
how to break them.  Many smart people trying and failing to do so
gives a good general feeling, but nothing more.  It remains hope.

How can you claim that modern cryptosystems are immune to known
plaintext attacks?

Jörn

-- 
When you close your hand, you own nothing. When you open it up, you
own the whole world.
-- Li Mu Bai in Tiger & Dragon
