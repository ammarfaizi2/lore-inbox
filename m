Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318295AbSHKNJc>; Sun, 11 Aug 2002 09:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318298AbSHKNJc>; Sun, 11 Aug 2002 09:09:32 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:17815 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S318295AbSHKNJc>;
	Sun, 11 Aug 2002 09:09:32 -0400
Date: Sun, 11 Aug 2002 09:13:19 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Rob Landley <landley@trommello.org>
cc: "H. Peter Anvin" <hpa@zytor.com>,
       "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org
Subject: Re: klibc development release
In-Reply-To: <200208111002.g7BA2Ga64100@pimout3-int.prodigy.net>
Message-ID: <Pine.GSO.4.21.0208110900440.13360-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Aug 2002, Rob Landley wrote:

> What's wrong with LGPL?  I thought libraries were what it was originally 

klibc is static-only.  So for all practical purposes LGPL would be every bit
as viral as GPV itself.

