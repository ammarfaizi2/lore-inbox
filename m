Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267406AbTALTSL>; Sun, 12 Jan 2003 14:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267410AbTALTSL>; Sun, 12 Jan 2003 14:18:11 -0500
Received: from tomts20-srv.bellnexxia.net ([209.226.175.74]:10662 "EHLO
	tomts20-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S267406AbTALTSK>; Sun, 12 Jan 2003 14:18:10 -0500
Subject: Re: [FIXED] 2.5 evolution problem
From: Shane Shrybman <shrybman@sympatico.ca>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1042397247.834.50.camel@phantasy>
References: <1042395383.2397.8.camel@mars.goatskin.org>
	 <1042397247.834.50.camel@phantasy>
Content-Type: text/plain
Organization: 
Message-Id: <1042399618.2777.2.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 12 Jan 2003 14:26:58 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-12 at 13:47, Robert Love wrote:
> On Sun, 2003-01-12 at 13:16, Shane Shrybman wrote:
> 
> > The bug causing problems with the evolution address book is fixed in
> > 2.5.56. I don't know if it was fixed in 2.5.55 or 2.5.56 but it was
> > broken in 2.5.54.
> 
> It was fixed in 2.5.55.
> 
> It works for me now, too, without using a hacked ORBit.
> 
> > This bug(#112) is listed as RESOLVED at bugme.osdl.org. Should it be
> > moved to CLOSED?
> 
> I guess so.

Ok, I will send a note to the bug owner.

> 
> > Also how would one find out what the resolution was at bugme.osdl.org?
> > Is there a pointer to patch or cset that I missed somewhere there?
> 
> Not sure if you can.
> 
> You can find the fix posted to lkml, though - Michael Meeks posted it. 
> It was a simple fix in the getpeername() code as we thought.

Ah yes I see it now, thanks.
> 
> 	Robert Love

Shane

