Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270696AbTHAJKN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 05:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270697AbTHAJKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 05:10:13 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:26522
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S270696AbTHAJKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 05:10:10 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: John Bradford <john@grabjohn.com>
Subject: Re: Messing with Kconfig.
Date: Fri, 1 Aug 2003 05:12:28 -0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, szepe@pinerecords.com
References: <200308010901.h7191Wsd000946@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200308010901.h7191Wsd000946@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308010512.28479.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 August 2003 05:01, John Bradford wrote:
> > So I'm looking at menuconfig and contemplating rearranging the heck out
> > of it
>
> Please don't.  This comes up from time to time on the mailing list,
> and massive re-arrangements are usually a Bad Thing.
>
> John.

I know a big flag day rearrangement would never be accepted.  It would have to 
be a series of small, self-contained patches that could be individually 
approved or vetoed.  (And several of them will be vetoed, this is normal.)

I know the drill.  You get there from here in quarter-inch steps...

Rob

