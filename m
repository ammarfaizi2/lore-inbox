Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261867AbSJZNue>; Sat, 26 Oct 2002 09:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262130AbSJZNue>; Sat, 26 Oct 2002 09:50:34 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:18962 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S261867AbSJZNud>; Sat, 26 Oct 2002 09:50:33 -0400
Date: Sat, 26 Oct 2002 15:53:46 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Adrian Pop <adrpo@ida.liu.se>
Cc: Adam Kropelin <akropel1@rochester.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: The pain with the Net Drivers (ne*, xirc2ps_c, etc)
Message-ID: <20021026135346.GB29595@louise.pinerecords.com>
References: <20021026044500.GA11483@www.kroptech.com> <Pine.GSO.4.44.0210260712300.11632-100000@mir20.ida.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0210260712300.11632-100000@mir20.ida.liu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Both gived the errors under medium load with
> the original timeout: TX_TIMEOUT (20*HZ/100).
> They reported no error and worked perfectly after
> changing TX_TIMEOUT to (100*HZ/100)

Your ethernet is on fire.
Either that, or your machine is somehow not quite healthy.

Considering your "it really doesn't matter the computer",
I'd vote for the former, though.

T.
