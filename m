Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpIKIl+rQ2gBlTtqmQf01qGEyPQ==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sun, 04 Jan 2004 17:03:29 +0000
Message-ID: <021b01c415a4$8288a6b0$d100000a@sbs2003.local>
Subject: Re: Pentium M config option for 2.6
Content-Class: urn:content-classes:message
From: "Rob Love" <rml@ximian.com>
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
To: <Administrator@smtp.paston.co.uk>
Cc: "Mikael Pettersson" <mikpe@csd.uu.se>, <szepe@pinerecords.com>,
        <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20040104165028.GC31585@redhat.com>
References: <200401041227.i04CReNI004912@harpo.it.uu.se> <1073228608.2717.39.camel@fur> <20040104162516.GB31585@redhat.com> <1073233988.5225.9.camel@fur>  <20040104165028.GC31585@redhat.com>
Content-Type: text/plain;
	charset="iso-8859-1"
MIME-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Mon, 29 Mar 2004 16:42:58 +0100
Content-Transfer-Encoding: 7bit
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:42:58.0359 (UTC) FILETIME=[82A07470:01C415A4]

On Sun, 2004-01-04 at 11:50, Dave Jones wrote:

> FWIW, I agree with it too on the grounds that its non obvious the optimal
> setting is CONFIG_MPENTIUMIII. This seems cleaner IMO than changing the
> helptext to read...
> 
>  "Pentium II"
>  "Pentium III / Pentium 4M"
>  "Pentium 4"

Oh, very much agreed.  Giving it a separate configure option also opens
the door for easily adding an march=pentiumm whenever the gcc folks get
around to adding that.

> My other mail may have sounded like I objected to the patch per se, I don't.

I did not think that, I thought perhaps that you thought that I objected
:)

	Rob Love

