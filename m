Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316592AbSG3VUk>; Tue, 30 Jul 2002 17:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316599AbSG3VUk>; Tue, 30 Jul 2002 17:20:40 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:23271 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S316592AbSG3VUj>; Tue, 30 Jul 2002 17:20:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Eric Altendorf <EricAltendorf@orst.edu>
Reply-To: EricAltendorf@orst.edu
To: Wade <neroz@iinet.net.au>
Subject: Re: 2.5.25: spurious 8259A interrupt: IRQ7
Date: Tue, 30 Jul 2002 13:54:07 -0700
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <200207300952.28460.EricAltendorf@orst.edu> <200207301042.31667.EricAltendorf@orst.edu> <1028063051.487.65.camel@debian>
In-Reply-To: <1028063051.487.65.camel@debian>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207301354.07552.EricAltendorf@orst.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 July 2002 14:04, Wade wrote:
> On Wed, 2002-07-31 at 03:42, Eric Altendorf wrote:
> > OK -- I'll take that explanation.  I mentioned it because it
> > happened in the first half hour of using this kernel
> > specifically, and I'd never seen it before.
>
> I only see this if I have IO-APIC turned on for a uniprocessor
> system.

FWIW, I don't have IO-APIC turned on (and didn't before either)

eric

-- 
"First they ignore you.  Then they laugh at you.
 Then they fight you.  And then you win."             -Gandhi
