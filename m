Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267329AbTCEQni>; Wed, 5 Mar 2003 11:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267335AbTCEQnh>; Wed, 5 Mar 2003 11:43:37 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:58886 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S267329AbTCEQnh>; Wed, 5 Mar 2003 11:43:37 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303051655.h25Gtjqx005881@81-2-122-30.bradfords.org.uk>
Subject: Re: Unable to boot a raw kernel image :??
To: hpa@zytor.com (H. Peter Anvin)
Date: Wed, 5 Mar 2003 16:55:45 +0000 (GMT)
Cc: raul@pleyades.net, linux-kernel@vger.kernel.org
In-Reply-To: <3E662A5C.4060307@zytor.com> from "H. Peter Anvin" at Mar 05, 2003 08:48:28 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Doesn't the in kernel bootloader have uses other than booting from
> > floppy?  What if you want to boot from a custom network boot prom?
> > 
> 
> Then you probably need Etherboot.  The in-kernel boot loader
> (bootsect.S) will not help you.

Sorry, I was thinking about something completely different :-).

John.
