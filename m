Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265414AbTA1NnE>; Tue, 28 Jan 2003 08:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265306AbTA1NnE>; Tue, 28 Jan 2003 08:43:04 -0500
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:48016 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S265414AbTA1NnD> convert rfc822-to-8bit;
	Tue, 28 Jan 2003 08:43:03 -0500
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Stefan Reinauer <stepan@suse.de>, Robert Morris <rob@r-morris.co.uk>
Subject: Re: Bootscreen
Date: Tue, 28 Jan 2003 14:52:02 +0100
User-Agent: KMail/1.4.1
Cc: Raphael Schmid <Raphael_Schmid@CUBUS.COM>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <398E93A81CC5D311901600A0C9F2928946936D@cubuss2> <Pine.LNX.4.44.0301281113480.20283-100000@schubert.rdns.com> <20030128133252.GC23296@suse.de>
In-Reply-To: <20030128133252.GC23296@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301281452.02856.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 January 2003 14:32, Stefan Reinauer wrote:
> * Robert Morris <rob@r-morris.co.uk> [030128 12:20]:
> > There is a very simple reason why Linux shouldn't have a "bootscreen" -
> > its a lame idea. We have copied enough of the bad "features" of Windows
> > et al into Linux already, IMHO.

I'm working for a company doing VoD and IPTV applications, and you surely 
don't want some verbose kernel output upon booting set-top-boxes. At least - 
the customer doesn't want it, meaning you shouldn't have it. Then it's better 
to have some LED flashing in case of error.

roy

-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

