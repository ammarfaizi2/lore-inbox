Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272531AbTGaQhx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 12:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272543AbTGaQhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 12:37:53 -0400
Received: from e166066.upc-e.chello.nl ([213.93.166.66]:45981 "EHLO
	hypnos.var.cx") by vger.kernel.org with ESMTP id S272531AbTGaQhY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 12:37:24 -0400
Date: Thu, 31 Jul 2003 18:37:18 +0200
From: Frank v Waveren <fvw@var.cx>
To: James Morris <jmorris@intercode.com.au>
Cc: linux-kernel@vger.kernel.org, linux-crypto@nl.linux.org
Subject: Re: 2.6.0-test2+Util-linux/cryptoapi
Message-ID: <1059669067FAU.fvw@tracks.var.cx>
References: <1059627605AME.fvw@tracks.var.cx> <Mutt.LNX.4.44.0307311515260.21304-100000@excalibur.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Mutt.LNX.4.44.0307311515260.21304-100000@excalibur.intercode.com.au>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 03:20:48PM +1000, James Morris wrote:
> > Owch. But I assume this didn't sneak in since the testing cryptoAPI
> > patches? Or have the algorithms been redone?
> I'm not sure what you mean.
I'm currently using hvr's testing cryptoAPI patches for 2.4.x, and I
have a block device encrypted with 256 bits serpent. This cannot be
correctly decrypted with linux-2.6.0-test2. Has something in the use
of serpent changed since then (or has block numbering changed again)?
Or should I go bug-hunting?

-- 
Frank v Waveren                                      Fingerprint: 21A7 C7F3
fvw@[var.cx|stack.nl|chello.nl] ICQ#10074100            1FF3 47FF 545C CB53
Public key: hkp://wwwkeys.pgp.net/fvw@var.cx            7BD9 09C0 3AC1 6DF2
