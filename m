Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292133AbSBTSAF>; Wed, 20 Feb 2002 13:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292142AbSBTR75>; Wed, 20 Feb 2002 12:59:57 -0500
Received: from mail6.speakeasy.net ([216.254.0.206]:3459 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP
	id <S292133AbSBTR7s> convert rfc822-to-8bit; Wed, 20 Feb 2002 12:59:48 -0500
Content-Type: text/plain; charset=US-ASCII
From: Derek Gladding <derek_gladding@altavista.net>
Reply-To: derek_gladding@altavista.net
To: linux-kernel@vger.kernel.org
Subject: Re: jiffies rollover, uptime etc.
Date: Wed, 20 Feb 2002 09:56:50 -0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020220172052.GA15228@matchmail.com> <Pine.LNX.4.44L.0202201423170.1413-100000@duckman.distro.conectiva> <20020220173216.GC15228@matchmail.com>
In-Reply-To: <20020220173216.GC15228@matchmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020220175953Z292133-890+2997@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 February 2002 09:32 am, Mike Fedyk wrote:
> On Wed, Feb 20, 2002 at 02:24:42PM -0300, Rik van Riel wrote:
> > On Wed, 20 Feb 2002, Mike Fedyk wrote:
> > > On Wed, Feb 20, 2002 at 01:36:02PM +0200, Ville Herva wrote:
> > > > asm-ia64/param.h:# define HZ    1024
> > > > asm-x86_64/param.h:#define HZ 100
> > >
> > > What's the difference between these two architectures?  Intel
> > > 64bit processor and AMD's upcoming 64bit processor?
> >
> > One is a 64 bit extension to a modern superscalar
> > architecture which has descended from 8 bit machines
> > over the ages.
> >
> > The other is a 3-issue VLIW follow-up to the 2-issue
> > VLIW i860.
>
> Oh, I didn't know that processor was used for more than printers,
> raid controllers, and similar.

IIRC, the i960 is the printer/controller arch, the i860 was the
(alleged) "cray-on-a-chip" number cruncher.

- Derek
