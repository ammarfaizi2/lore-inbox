Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268164AbRGWJNx>; Mon, 23 Jul 2001 05:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268163AbRGWJNn>; Mon, 23 Jul 2001 05:13:43 -0400
Received: from ns.suse.de ([213.95.15.193]:60429 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S268161AbRGWJN2>;
	Mon, 23 Jul 2001 05:13:28 -0400
Mail-Copies-To: never
To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Problem: Large file I/O waits (almost) forever
In-Reply-To: <Pine.LNX.4.30.0107231043520.24403-100000@biker.pdb.fsc.net>
From: Andreas Jaeger <aj@suse.de>
Date: Mon, 23 Jul 2001 11:13:33 +0200
In-Reply-To: <Pine.LNX.4.30.0107231043520.24403-100000@biker.pdb.fsc.net>
 (Martin Wilck's message of "Mon, 23 Jul 2001 11:05:04 +0200 (CEST)")
Message-ID: <hopuas9feq.fsf@gee.suse.de>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Martin Wilck <Martin.Wilck@fujitsu-siemens.com> writes:

> Hi,
> 
> I just came across the following phenomenon and would like to inquire
> whether it's a feature or a bug, and what to do about it:
> 
> I have run our "copy-compare" test during the weekend to test I/O
> stability on a IA64 server running 2.4.5. The test works by generating
> a collection of binary files with specified lengths, copying them between
> different directories, and checking the result a) by checking the
> predefined binary patterns and b) by comparing source and destination with cmp.

Under what filesystem and with what kind of hardware did you run this?

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
