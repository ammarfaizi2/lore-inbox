Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261613AbTCGOyv>; Fri, 7 Mar 2003 09:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261653AbTCGOyu>; Fri, 7 Mar 2003 09:54:50 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:47110 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S261613AbTCGOyu>; Fri, 7 Mar 2003 09:54:50 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303071506.h27F6egj001846@81-2-122-30.bradfords.org.uk>
Subject: Re: Make ipconfig.c work as a loadable module.
To: linux@discworld.dyndns.org (Charles Cazabon)
Date: Fri, 7 Mar 2003 15:06:40 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030307084357.A10344@discworld.dyndns.org> from "Charles Cazabon" at Mar 07, 2003 08:43:57 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Anything built static against glibs tends to be 400K+.
> 
> So don't use glibc.  Link staticly against diet-libc or klibc.

Or newlib.

John.
