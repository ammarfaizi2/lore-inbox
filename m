Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281874AbRK1EOs>; Tue, 27 Nov 2001 23:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281878AbRK1EOi>; Tue, 27 Nov 2001 23:14:38 -0500
Received: from zero.tech9.net ([209.61.188.187]:20490 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S281874AbRK1EO3> convert rfc822-to-8bit;
	Tue, 27 Nov 2001 23:14:29 -0500
Subject: Re: Unresponiveness of 2.4.16
From: Robert Love <rml@tech9.net>
To: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Andrew Morton <akpm@zip.com.au>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <200111280353.fAS3rEB05638@zero.tech9.net>
In-Reply-To: <20011128013129Z281843-17408+21534@vger.kernel.org>
	<3C044855.3CF2DCA3@zip.com.au>
	<20011127183429.B862@mikef-linux.matchmail.com> 
	<200111280353.fAS3rEB05638@zero.tech9.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 27 Nov 2001 23:14:53 -0500
Message-Id: <1006920894.820.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-11-27 at 22:53, Dieter Nützel wrote:

> To Robert Love:
> I get the following in dmesg:
> lock-break-rml-2.4.16-1.patch
> 
> date: busy buffer
> lock_break: buffer.c:681: count was 2 not 551
> invalidate: busy buffer
> lock_break: buffer.c:681: count was 2 not 551
> invalidate: busy buffer

Thanks for the feedback, Dieter.

	Robert Love

