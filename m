Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264959AbUELDNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264959AbUELDNc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 23:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264958AbUELDNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 23:13:32 -0400
Received: from host213-123-250-229.in-addr.btopenworld.com ([213.123.250.229]:27693
	"EHLO 2003SERVER.sbs2003.local") by vger.kernel.org with ESMTP
	id S265012AbUELDMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 23:12:46 -0400
thread-index: AcQ3z3EibDfYC46bRxuORkeQJsOdAQ==
X-Sieve: Server Sieve 2.2
Date: Wed, 12 May 2004 04:15:56 +0100
From: "Daniel Jacobowitz" <dan@debian.org>
To: <Administrator@vger.kernel.org>
Cc: <benh@kernel.crashing.org>, <linux-kernel@vger.kernel.org>,
       <linuxppc-dev@lists.linuxppc.org>
Message-ID: <000101c437cf$71227ca0$d100000a@sbs2003.local>
Subject: Re: [PATCH 1/2] PPC32: New OCP core support
Content-Transfer-Encoding: 7bit
Mail-Followup-To: Matt Porter <mporter@kernel.crashing.org>,benh@kernel.crashing.org, linux-kernel@vger.kernel.org,linuxppc-dev@lists.linuxppc.org
References: <20040511170150.A4743@home.com> <20040511175750.12bad316.akpm@osdl.org> <000101c437c2$d7467ac0$d100000a@sbs2003.local>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
X-Mailer: Microsoft CDO for Exchange 2000
Content-Disposition: inline
In-Reply-To: <000101c437c2$d7467ac0$d100000a@sbs2003.local>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Mailing-List: <linuxppc-dev@lists.linuxppc.org>
X-Loop: linuxppc-dev@lists.linuxppc.org
Content-Class: urn:content-classes:message
Importance: normal
Envelope-to: paul@sumlocktest.fsnet.co.uk
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.132
X-me-spamlevel: not-spam
X-me-spamrating: 2.641677
X-OriginalArrivalTime: 12 May 2004 03:15:57.0093 (UTC) FILETIME=[713F0550:01C437CF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, May 12, 2004 at 02:45:44AM +0100, Matt Porter wrote:
>
> On Tue, May 11, 2004 at 05:57:50PM -0700, Andrew Morton wrote:
> > Matt Porter <mporter@kernel.crashing.org> wrote:
> > >
> > > New OCP infrastructure ported from 2.4 along with several
> > > enhancements. Please apply.
> >
> > I only received patch 1/2.
> >
> > Could you please avoid using the same Subject: for different patches?  It
> > confuses my auto-subject-to-patch-filename-munger and it's nice to more
> > specifically identify each patch anwyay.
>
> Oddly I sent unique subjects:
>
> 	Subject: [PATCH 1/2] PPC32: New OCP core support
> 	Subject: [PATCH 2/2] PPC32: PPC4xx updates for new OCP
>
> It appears 2/2 at least made it off my system to the remote mailer,
> will doublecheck.

Your mail is being duplicated by what looks like a broken news gateway,
or something similar, on linuxppc-dev:

Received: from host213-123-250-229.in-addr.btopenworld.com ([213.123.250.229]:15149
        "EHLO 2003SERVER.sbs2003.local") by vger.kernel.org with ESMTP
        id S264904AbUELBme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2004 21:42:34 -0400
Received: from mail pickup service by 2003SERVER.sbs2003.local with Microsoft SMTPSVC;
         Wed, 12 May 2004 02:45:44 +0100

>
> -Matt
>
>
>
>

--
Daniel Jacobowitz

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/


