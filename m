Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274875AbRK0J7z>; Tue, 27 Nov 2001 04:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282071AbRK0J7r>; Tue, 27 Nov 2001 04:59:47 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:8452 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S274875AbRK0J6b>; Tue, 27 Nov 2001 04:58:31 -0500
Message-ID: <3C036389.682422E6@idb.hist.no>
Date: Tue, 27 Nov 2001 10:57:29 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.1-pre1 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Anuradha Ratnaweera <anuradha@gnu.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.16
In-Reply-To: <Pine.LNX.4.21.0111261003070.13400-100000@freak.distro.conectiva> <20011127083530.A13584@bee.lk> <3C02FDF4.22927E4A@mandrakesoft.com> <20011127085621.A14241@bee.lk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anuradha Ratnaweera wrote:
> 
> On Mon, Nov 26, 2001 at 09:44:04PM -0500, Jeff Garzik wrote:
> > Anuradha Ratnaweera wrote:
> > >
> > > On Mon, Nov 26, 2001 at 10:30:08AM -0200, Marcelo Tosatti wrote:
> > > >
> > > > final:
> > > > - Fix 8139too oops                            (Philipp Matthias Hahn)
> > >
> > > Won't that be a good idea to keep the -final the same as the last -pre?
> >
> > No.  There is absolutely no reason not to fix this oops.
> 
> I wasn't refering to 8139 driver, but the kernel release policy.

A "policy" is a simplification that isn't needed.

This fix could trivially be proved not to make things worse, so
no reason at all to omit it.  Policies, rules-of-thumb etc.
is for management and others without detail knowledge.
Those who know better shouldn't be limited by such rules.
And they aren't. :-)

Of course it is possible to write down a detailed policy
that even expert coders could agree to - but why bother?
You wouldn't get it into a few lines...

Helge Hafting
