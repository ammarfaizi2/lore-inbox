Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268262AbUHYF7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268262AbUHYF7a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 01:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268308AbUHYF7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 01:59:30 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:23758 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S268262AbUHYF72 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 01:59:28 -0400
From: Andrew Miklas <public@mikl.as>
Reply-To: public@mikl.as
To: Gianni Tedesco <gianni@scaramanga.co.uk>
Subject: Re: Linux Incompatibility List
Date: Wed, 25 Aug 2004 01:59:10 -0400
User-Agent: KMail/1.6.2
Cc: Wakko Warner <wakko@animx.eu.org>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <87r7q0th2n.fsf@dedasys.com> <200408211955.44914.public@mikl.as> <1093233294.26293.46.camel@sherbert>
In-Reply-To: <1093233294.26293.46.camel@sherbert>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200408250159.20606.public@mikl.as>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

On August 22, 2004 11:54 pm, Gianni Tedesco wrote:
<snip>
> There is at least 1 effort underway to reverse engineer it, although I
> don't have much time to work on it. IMO It would be good if such
> companies were consistently shown that we certainly don't need them to
> write drivers for us and even if they go out of their way, there isn't
> much they can do to stop us from writing them ourselves.

I've been working with a few people to reverse engineer the drivers included 
with the WAP54G 1.08.  We're about 50% done translating them back into C.  
Once we're done, we plan to study the driver in order to write our own from 
scratch, or ask someone else to cleanroom it.

However, it's likely that by the time we're done (if ever), the hardware will 
be supplanted by something else.  We've learnt the hard way that reverse 
engineering a 420K binary, and completing in a reasonable time isn't as easy 
as it sounds.  :)  This is especially true when you can't simply make 
everything public (out of copyright concerns) and do the project in a real 
open source way.  


- -- Andrew
-----BEGIN PGP SIGNATURE-----
Comment: Key ID: EC3F6CCD (www.keyserver.net)

iD8DBQFBLCqyTHKGaOw/bM0RAhsjAKCH6Ftt9gp5raK2PfPEfDoKb8bxPwCeNY7y
ilSEs+jG1514W6zz/WGBNQg=
=QrAv
-----END PGP SIGNATURE-----
