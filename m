Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262624AbSJBVq6>; Wed, 2 Oct 2002 17:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262627AbSJBVq6>; Wed, 2 Oct 2002 17:46:58 -0400
Received: from pegasus.mail.eclipse.net.uk ([212.104.129.225]:5652 "HELO
	pegasus.mail.eclipse.net.uk") by vger.kernel.org with SMTP
	id <S262624AbSJBVqz>; Wed, 2 Oct 2002 17:46:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Peter L Jones <peter@drealm.org.uk>
Organization: The Dwarfen Realm
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: kernel BUG at slab.c:1292
Date: Wed, 2 Oct 2002 22:52:02 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200210021935.51996@advent.drealm.org.uk> <20021002193252.GA1883@ppc.vc.cvut.cz>
In-Reply-To: <20021002193252.GA1883@ppc.vc.cvut.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210022252.03129@advent.drealm.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 Oct 2002 20:32, Petr Vandrovec wrote:
> On Wed, Oct 02, 2002 at 07:35:51PM +0100, Peter L Jones wrote:
> > Hi all,
> >
> > I asked on #kernelnewbies what I should do with this and was told to
> > check the mailing list archive at http://marc.theaimsgroup.com/ - which
> > I've done.
> >
> > The following was produced during boot.  I _looks_ like it was during a
> > modprobe, but I'm not entirely sure what - it could be that binfmt_misc
> > but I couldn't find any docs in the tree for BUG() tracebacks (and I
> > probably wouldn't have understood the source).
> >
> > I'm not subscribed to the list: if anyone wants more info, drop me
> > private mail and I'll see what I can do.
>
> Try this. I just sent it to Linus.
> 						Petr Vandrovec
>

Petr,

This appears to have done the trick.

-- Peter

