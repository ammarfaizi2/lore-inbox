Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267383AbTALSih>; Sun, 12 Jan 2003 13:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267394AbTALSig>; Sun, 12 Jan 2003 13:38:36 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:33542
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267383AbTALSig>; Sun, 12 Jan 2003 13:38:36 -0500
Subject: Re: [FIXED] 2.5 evolution problem
From: Robert Love <rml@tech9.net>
To: Shane Shrybman <shrybman@sympatico.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1042395383.2397.8.camel@mars.goatskin.org>
References: <1042395383.2397.8.camel@mars.goatskin.org>
Content-Type: text/plain
Organization: 
Message-Id: <1042397247.834.50.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 12 Jan 2003 13:47:28 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-12 at 13:16, Shane Shrybman wrote:

> The bug causing problems with the evolution address book is fixed in
> 2.5.56. I don't know if it was fixed in 2.5.55 or 2.5.56 but it was
> broken in 2.5.54.

It was fixed in 2.5.55.

It works for me now, too, without using a hacked ORBit.

> This bug(#112) is listed as RESOLVED at bugme.osdl.org. Should it be
> moved to CLOSED?

I guess so.

> Also how would one find out what the resolution was at bugme.osdl.org?
> Is there a pointer to patch or cset that I missed somewhere there?

Not sure if you can.

You can find the fix posted to lkml, though - Michael Meeks posted it. 
It was a simple fix in the getpeername() code as we thought.

	Robert Love

