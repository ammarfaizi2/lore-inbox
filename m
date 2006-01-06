Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbWAFNjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbWAFNjm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 08:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWAFNjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 08:39:42 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:44559 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932403AbWAFNjl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 08:39:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=llZFbL4OJhQPXXeqbXT6t0A8UXOElctpv3XRuivDK5X2g8X05bxWm4iSALNpkScmSCUGL6yEN6qFVmhuL/udMzJGtYmnz/5KdhtJoMa0IIwlJGAwvIlcuF1bYkb993ulzNRuqOBgPLxsrY3d1FpbYJ4CJDr2MkQnGrqP3XC47pA=
Message-ID: <5a2cf1f60601060539k47ba157cy36ca18046575d4fe@mail.gmail.com>
Date: Fri, 6 Jan 2006 14:39:40 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
To: Sebastian <sebastian_ml@gmx.net>
Subject: Re: Digital Audio Extraction with ATAPI drives far from perfect
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060104155036.GA5542@section_eight.mops.rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060103222044.GA17682@section_eight.mops.rwth-aachen.de>
	 <20060104092058.GN3472@suse.de> <20060104092443.GO3472@suse.de>
	 <20060104155036.GA5542@section_eight.mops.rwth-aachen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/06, Sebastian <sebastian_ml@gmx.net> wrote:
> Hello all! Hi Jens!

[...]

> I used the wav compare function in EAC.
>
> 1. wav ripped by EAC
> ####################
>
> What happened?          Where?
> -------------------------------------------------
>
> Different samples       0:04:08.318 - 0:04:08.362
> 2100 missing samples    0:04:08.359
> Different samples       0:04:08.430 - 0:04:08.433
> Different samples       0:04:09.348 - 0:04:09.398
>
> 2. wav ripped by cdparanoia
> ###########################
>
> What happened?          Where?
> -------------------------------------------------
>
> Different samples       0:04:08.318 - 0:04:08.362
> 2039 missing samples    0:04:08.414
> Different samples       0:04:08.431 - 0:04:08.434
> Different samples       0:04:09.349 - 0:04:09.399
>
> I'm sorry if this isn't what you had in mind when you told me to compare
> the wav files. If it doesn't help what can I do to compare the files to
> your liking?

It's funny. It looks like the problems happened twice in the more or
less same position.

Jerome
