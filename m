Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267507AbUJJJMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267507AbUJJJMW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 05:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268212AbUJJJMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 05:12:22 -0400
Received: from poulet.zoy.org ([80.65.228.129]:31671 "EHLO poulet.zoy.org")
	by vger.kernel.org with ESMTP id S267507AbUJJJMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 05:12:19 -0400
Date: Sun, 10 Oct 2004 11:12:18 +0200
From: Sam Hocevar <sam@zoy.org>
To: "Yoshinori K. Okuji" <okuji@gnu.org>
Cc: linux-kernel@vger.kernel.org, videolan@videolan.org
Subject: Re: possible GPL violation by Free
Message-ID: <20041010091215.GD1750@zoy.org>
References: <200410091958.25251.okuji@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410091958.25251.okuji@gnu.org>
Mail-Copies-To: never
X-No-CC: I read mailing-lists; do not CC me on replies.
X-Snort: uid=0(root) gid=0(root)
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 09, 2004, Yoshinori K. Okuji wrote:

> I got information about a possible GPL violation in France. A network
> service company called "Free" provides a kind of ADSL modem named
> "Freebox". This "Freebox" is not only an ADSL modem but also has
> functions of a router, an IP phone and a TV, using video streaming via
> ATM. Although the "Freebox" does not contain any information about GPL,
> a rumor says that this runs Linux as the kernel and VideoLAN for the
> video streaming.

   The Freebox does not run VideoLAN software but has a built-in
hardware MPEG-2 decoder. Free uses VideoLAN software to stream video,
but this is internal use and perfectly complies with the GPL. I may add
that a VideoLAN developer works for Free and still commits code into the
SVN repository, which he is not required to do.

   If there is a problem here, it looks like a problem with Linux (and
probably GNU) only.

> And, this company does not provide the source code
> even to those who have Freeboxes. I don't know any other software used
> in Freebox, but at least Linux and VideoLAN are under the term of GPL.
> This information seems to be given by anonymous people working for the
> company.
> 
> The company Free reasons that they don't need to make the source code
> available, because they don't sell Freebox but merely _rents_ Freebox
> to customers. So the company thinks that customers do not own Freebox
> legally, and so they have no right to claim that they can ask the
> source code.

   Do you have a reference to an official statement for this? A lot of
companies are rumoured to say a lot of things, and you should really
cautiously check your facts. If this is indeed they reasoning, it
impugns the general GPL interpretation that renting a piece of hardware
is distribution of the software therein.

   To carefully verify this, you need to have a Freebox user ask
Free for the Linux source code. No one else is entitled to do it.
Maybe you could even find a Linux developer who has a Freebox and did
contributions to the kernel significant enough that they must be in the
Freebox.

   If Free is using an unmodified kernel, they are already providing
the sources for it (ftp://ftp.free.fr/pub/linux/kernel/). If they are
using a modified version of the kernel, then they should be asked for
the source. If anyone is going to do this, please be diplomatic, and
try to rely on facts rather than Internet rumours. I would hate to see
Free exasperated by Slashdot morons and deciding not to contribute to
VideoLAN any longer.

Regards,
-- 
Sam. <http://sam.zoy.org/>
