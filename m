Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbTLJGHr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 01:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbTLJGHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 01:07:47 -0500
Received: from adsl173-178.dsl.uva.nl ([146.50.173.178]:22408 "EHLO
	hypnos.var.cx") by vger.kernel.org with ESMTP id S261890AbTLJGHq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 01:07:46 -0500
Date: Fri, 5 Dec 2003 18:28:06 +0100
From: Frank v Waveren <fvw@var.cx>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: David Wagner <daw-usenet@taverner.cs.berkeley.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: partially encrypted filesystem
Message-ID: <20031205172806.GB15738@var.cx>
References: <1070485676.4855.16.camel@nucleon> <20031204141725.GC7890@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0312040712270.2055@home.osdl.org> <20031204172653.GA12516@wohnheim.fh-wedel.de> <bqo1a2$s8i$1@abraham.cs.berkeley.edu> <20031205130202.GA31855@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031205130202.GA31855@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 02:02:02PM +0100, J?rn Engel wrote:
> How can you claim that modern cryptosystems are immune to known
> plaintext attacks?
Just as it's perfectly reasonable to say that factoring large
prime products is computationally infeasible. True, it might turn out
to be untrue, but it's one of the general assumptions you go
by when implementing a cryptographic system.

-- 
Frank v Waveren                                      Fingerprint: 21A7 C7F3
fvw@[var.cx|stack.nl|dse.nl] ICQ#10074100               1FF3 47FF 545C CB53
Public key: hkp://wwwkeys.pgp.net/fvw@var.cx            7BD9 09C0 3AC1 6DF2
