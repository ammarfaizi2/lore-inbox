Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319029AbSHMOCq>; Tue, 13 Aug 2002 10:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319030AbSHMOCq>; Tue, 13 Aug 2002 10:02:46 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:14264 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S319029AbSHMOCp>; Tue, 13 Aug 2002 10:02:45 -0400
Message-Id: <200208131406.g7DE6ab182576@pimout2-ext.prodigy.net>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Rob Landley <landley@trommello.org>
To: alan@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre1-ac2
Date: Tue, 13 Aug 2002 05:06:30 -0400
X-Mailer: KMail [version 1.3.1]
References: <200208120010.g7C0A4L22478@devserv.devel.redhat.com> <20020812010136.GA4818@stargate.lan>
In-Reply-To: <20020812010136.GA4818@stargate.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a nomenclature thing...

> On dim, 11 aoû 2002, Alan Cox wrote:
> > [+ indicates stuff that went to Marcelo, o stuff that has not,
> >  * indicates stuff that is merged in mainstream now, X stuff that proved
> >    bad and was dropped out, - indicates stuff not relevant to the main
> > tree]

> > Linux 2.4.19rc3-a1
> > o	Merge with 2.4.19rc3

> > Linux 2.4.19rc2-ac1
> > o	Merge with 2.4.19-rc2

Since these sorts of entries are never going to go to marcelo, perhaps they 
should be "-" instead of "o"?  (Just a noise reduction suggestion for those 
trying to see what's still pending in your tree that they won't find in 
Marcelo's.  No biggie...)

Rob
