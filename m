Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752298AbWFXPTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752298AbWFXPTL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 11:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933084AbWFXPTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 11:19:10 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:46492 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1752350AbWFXPTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 11:19:08 -0400
Date: Sat, 24 Jun 2006 11:18:58 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Theodore Tso <tytso@mit.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1: UML failing w/o SKAS enabled
Message-ID: <20060624151858.GA3627@ccure.user-mode-linux.org>
References: <20060621034857.35cfe36f.akpm@osdl.org> <20060622213443.GA22303@thunk.org> <20060623024222.GA8316@ccure.user-mode-linux.org> <20060623210714.GA16661@thunk.org> <20060623214623.GA7319@ccure.user-mode-linux.org> <20060624124354.GA7290@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060624124354.GA7290@thunk.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2006 at 08:43:54AM -0400, Theodore Tso wrote:
> It might be good to explicitly state that in the Kconfig
> documentation, in particular in the documentation for CONFIG_MODE_TT.

I'll fix those.

> Also, just as a suggestion, it might be a good idea to update the UML
> HOWTO in Documentation/uml/UserModeLinux-HOWTO.txt (or at least the
> November 18, 2002 date), and also the SKAS page at:
> 
> 	http://user-mode-linux.sourceforge.net/skas.html

Yeah, I'm working on updating the site - see 
	http://user-mode-linux.sourceforge.net/new/index.html
for what I have so far.
				Jeff
