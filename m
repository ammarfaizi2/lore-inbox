Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpIJ6RxXpegObQTSwDSwqlmSt7A==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sun, 04 Jan 2004 17:16:45 +0000
Message-ID: <021001c415a4$827a4ed0$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft CDO for Exchange 2000
Date: Mon, 29 Mar 2004 16:42:58 +0100
Content-Class: urn:content-classes:message
From: "Tomas Szepe" <szepe@pinerecords.com>
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
To: <Administrator@smtp.paston.co.uk>
Cc: "Dave Jones" <davej@redhat.com>, "Mikael Pettersson" <mikpe@csd.uu.se>,
        <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Pentium M config option for 2.6
References: <200401041227.i04CReNI004912@harpo.it.uu.se> <1073228608.2717.39.camel@fur> <20040104162516.GB31585@redhat.com> <1073233988.5225.9.camel@fur> <20040104165028.GC31585@redhat.com> <1073235682.5225.12.camel@fur>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1073235682.5225.12.camel@fur>
User-Agent: Mutt/1.4.1i
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:42:58.0375 (UTC) FILETIME=[82A2E570:01C415A4]

On Jan-04 2004, Sun, 12:01 -0500
Rob Love <rml@ximian.com> wrote:

> On Sun, 2004-01-04 at 11:50, Dave Jones wrote:
> 
> > FWIW, I agree with it too on the grounds that its non obvious the optimal
> > setting is CONFIG_MPENTIUMIII. This seems cleaner IMO than changing the
> > helptext to read...
> > 
> >  "Pentium II"
> >  "Pentium III / Pentium 4M"
> >  "Pentium 4"
> 
> Oh, very much agreed.  Giving it a separate configure option also opens
> the door for easily adding an march=pentiumm whenever the gcc folks get
> around to adding that.

Yes.  That was the door I was aiming to open. <g>

-- 
Tomas Szepe <szepe@pinerecords.com>
