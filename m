Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpIJ3B1wXeR95RUO7SOc4DcAF3g==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sun, 04 Jan 2004 16:52:43 +0000
Message-ID: <020e01c415a4$8277ddd0$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft CDO for Exchange 2000
Date: Mon, 29 Mar 2004 16:42:58 +0100
Content-Class: urn:content-classes:message
From: "Dave Jones" <davej@redhat.com>
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
To: <Administrator@smtp.paston.co.uk>
Cc: "Mikael Pettersson" <mikpe@csd.uu.se>, <szepe@pinerecords.com>,
        <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Pentium M config option for 2.6
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Rob Love <rml@ximian.com>, Mikael Pettersson <mikpe@csd.uu.se>,
	szepe@pinerecords.com, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200401041227.i04CReNI004912@harpo.it.uu.se> <1073228608.2717.39.camel@fur> <20040104162516.GB31585@redhat.com> <1073233988.5225.9.camel@fur>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1073233988.5225.9.camel@fur>
User-Agent: Mutt/1.5.4i
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:42:58.0140 (UTC) FILETIME=[827F09C0:01C415A4]

On Sun, Jan 04, 2004 at 11:33:08AM -0500, Rob Love wrote:

 > Yah.  I was just answering in the abstract to the "does cache line
 > matter on non-SMP" question.
 > 
 > I actually like this patch (perhaps since I have a P-M :) and think it
 > ought to go in, although I agree with others that the P-M is more of a
 > super-P3 than a scaled down P4.

FWIW, I agree with it too on the grounds that its non obvious the optimal
setting is CONFIG_MPENTIUMIII. This seems cleaner IMO than changing the
helptext to read...

 "Pentium II"
 "Pentium III / Pentium 4M"
 "Pentium 4"

My other mail may have sounded like I objected to the patch per se, I don't.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
