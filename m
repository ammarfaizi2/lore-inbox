Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbTJASaX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 14:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbTJAS2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 14:28:46 -0400
Received: from chello062179073041.chello.pl ([62.179.73.41]:42889 "EHLO
	pioneer.space.nemesis.pl") by vger.kernel.org with ESMTP
	id S262570AbTJAS15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 14:27:57 -0400
Date: Wed, 1 Oct 2003 20:27:07 +0200 (CEST)
From: Tomasz Rola <rtomek@cis.com.pl>
To: kartikey bhatt <kartik_me@hotmail.com>
cc: linux-kernel@vger.kernel.org, paul@clubi.ie,
       Tomasz Rola <rtomek@cis.com.pl>
Subject: Re: Can't X be elemenated?
In-Reply-To: <Law11-F67ATnLE7P95L00001388@hotmail.com>
Message-ID: <Pine.LNX.3.96.1031001195757.9507B-100000@pioneer.space.nemesis.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 1 Oct 2003, kartikey bhatt wrote:

[...]
> 2. On top of that, one can develop complete lightweight GUI.

I wonder how such a move would impact the users of other free OSes like
FreeBSD. They use the same X afaik.

I think you might get locked into this new gui like in the trap. X is not
lightweight but it is kind of universal. This means, you can get app
written originally for Solaris or SGI and in most cases you "just
recompile" it and it's available on Linux. Just like this. And if you
started forcing new gui, some people would stay with X and some would
switch - all of this might do nothing good to growing the number of 
applications that could run on Linux.

Such a lightweight gui is nowadays needed only on some very specific
platforms, IMHO. Those with less memory and cpu, like handhelds and other
embedded applications.

Think of MS Windows family - they are a real bloat but they are more or
less unified. Not that I admire the way MS did it but I think I can still
run 16-bit apps on Win 2000 (if I really wanted to trash filesystem with
old dlls). This ability to accumulate applications over long period of
time shouldn't be discarded. In reality, you would probably have ended
with a small number of people using lightweight gui and the rest of people
staying with X, which has better support and good number of developers.
Right now, the only real alternative is - in my opinion -
QTopia/QTEmbedded/Opie. You can try to run this on your PC (I think I have
read somewhere on the net it is possible). 

If, on the other hand, you would like to see what happens to less used
guis, try looking on this:

http://hack.org/~mc/mgr/index.html

MGR has nice minimalistic look but isn't in very active development today.
Guess why? It aimed to be 10x faster than X for example, but today
hardware has more power and X has improved too.

On the other hand, if all you need is terminal emulator and some other
similar apps, you may find what you are looking for. But I really think
all of your problems come from some badly written driver or an app eating
too much memory. Not X as a kind of gui but poor implementation.

[...]
> you don't know my frustration when i got PC and wasn't able to
> run X until i810 agp gart support was available at kernel level.

You know, while waiting for the support to come, you can use some cheap
old pci card. I have seen used Matrox Millenium 2 for about $4. I myself
use mm2/agp and it gives me great desktop, excellent for reading and
writing texts and watching tv. Just enough power to work. Very stable,
sharp etc. On the other hand they tend to be treated like a trash because
of not having support for all these fancy 3d things.

And next time before buying a mobo, try to ensure it is already supported
under Linux. The same applies to onboard sound and ether.

[...]
> and if you are feeling very unhappy about my statement X is bloat,
> I really apologize for that.

I don't feel unhappy with this but I think you can do much better - since
my old matrox w/4m ram has no problems with handling me without hickup.

How about trying some development version of X from CVS? Or asking about
your chipset on X-related newsgroup?

bye
T.

- --
** A C programmer asked whether computer had Buddha's nature.      **
** As the answer, master did "rm -rif" on the programmer's home    **
** directory. And then the C programmer became enlightened...      **
**                                                                 **
** Tomasz Rola          mailto:tomasz_rola@bigfoot.com             **

-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 5.0i for non-commercial use
Charset: noconv

iQA/AwUBP3schBETUsyL9vbiEQLznQCdFxF3xMja6bp667Jw9oVLV4hnjp4AoPYo
YYl31jQtxtTzloiBZmb1yzdw
=iZ5a
-----END PGP SIGNATURE-----


