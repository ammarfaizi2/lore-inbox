Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282869AbRK0I0p>; Tue, 27 Nov 2001 03:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282868AbRK0I0f>; Tue, 27 Nov 2001 03:26:35 -0500
Received: from ns.suse.de ([213.95.15.193]:37382 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S282869AbRK0I0W>;
	Tue, 27 Nov 2001 03:26:22 -0500
Mail-Copies-To: never
To: Anuradha Ratnaweera <anuradha@gnu.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.16
In-Reply-To: <20011127083530.A13584@bee.lk>
	<Pine.LNX.4.33L.0111270551210.4079-100000@imladris.surriel.com>
	<20011127135847.A22859@bee.lk>
From: Andreas Jaeger <aj@suse.de>
Date: Tue, 27 Nov 2001 09:26:20 +0100
In-Reply-To: <20011127135847.A22859@bee.lk> (Anuradha Ratnaweera's message
 of "Tue, 27 Nov 2001 13:58:47 +0600")
Message-ID: <ho1yik39hv.fsf@gee.suse.de>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anuradha Ratnaweera <anuradha@gnu.org> writes:

> On Tue, Nov 27, 2001 at 05:51:59AM -0200, Rik van Riel wrote:
>> On Tue, 27 Nov 2001, Anuradha Ratnaweera wrote:
>> > On Mon, Nov 26, 2001 at 10:30:08AM -0200, Marcelo Tosatti wrote:
>> > >
>> > > final:
>> > > - Fix 8139too oops				(Philipp Matthias Hahn)
>> >
>> > Won't that be a good idea to keep the -final the same as the last -pre?
>> 
>> That's basically what happened. This 8139too fix is
>> ONE LINE, in a self-contained piece of code.
>
> It is still not okey to include even _small_ changes, because it is hard to
> define what small is.  Although we are sure that is is going to break,
> Murphey's laws may get in ...;)

It's Marcelo deciding what it's ok and what not.  He's the one
responsible for it.  If you like to give him a friendly advise - fine
with me but I don't think you've got the right to *define* what's ok
and what not for Marcelo.

I've got the impression from these threads about maintaince on lkml
that a number of people try to force something on Marcelo without
giving him a chance to find his own way of doing it.  I trust Marcelo
that he'll do the right thing.

Could we get back to coding and testing?

Andreas

P.S. I trimmed the CC list to only include lkml.
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
