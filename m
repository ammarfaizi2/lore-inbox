Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283775AbRLEFVJ>; Wed, 5 Dec 2001 00:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283768AbRLEFVA>; Wed, 5 Dec 2001 00:21:00 -0500
Received: from smtpsrv1.isis.unc.edu ([152.2.1.138]:2193 "EHLO
	smtpsrv1.isis.unc.edu") by vger.kernel.org with ESMTP
	id <S283767AbRLEFUy>; Wed, 5 Dec 2001 00:20:54 -0500
Date: Wed, 5 Dec 2001 00:20:51 -0500 (EST)
From: "Daniel T. Chen" <crimsun@email.unc.edu>
To: Josh McKinney <forming@home.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Fwd: binutils in debian unstable is broken.
In-Reply-To: <20011205050513.GD1442@cy599856-a.home.com>
Message-ID: <Pine.A41.4.21L1.0112050018290.34322-100000@login3.isis.unc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yep, but this seems to be a real PIA to catch. Different .configs trigger
it differently and sometimes not at all. We're testing a couple patches at
the moment.

Earlier I stated incorrectly that it is a binutils bug; sorry for  
misleading information. Instead it seems Debian sid's latest binutils
package is much more strict.

---
Dan Chen                 crimsun@email.unc.edu
GPG key: www.cs.unc.edu/~chenda/pubkey.gpg.asc

On Wed, 5 Dec 2001, Josh McKinney wrote:

> This seems to be a kernel bug which is shown with the new version of ld.  Thought I would
> forward this along so maybe it can get fixed.

