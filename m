Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272798AbRIGSDK>; Fri, 7 Sep 2001 14:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272799AbRIGSDA>; Fri, 7 Sep 2001 14:03:00 -0400
Received: from mhw.ulib.iupui.edu ([134.68.164.123]:16879 "EHLO
	mhw.ULib.IUPUI.Edu") by vger.kernel.org with ESMTP
	id <S272798AbRIGSCw>; Fri, 7 Sep 2001 14:02:52 -0400
Date: Fri, 7 Sep 2001 13:03:12 -0500 (EST)
From: "Mark H. Wood" <mwood@IUPUI.Edu>
X-X-Sender: <mwood@mhw.ULib.IUPUI.Edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war 
In-Reply-To: <200109071228.f87CSNMN017085@pincoya.inf.utfsm.cl>
Message-ID: <Pine.LNX.4.33.0109071258050.4509-100000@mhw.ULib.IUPUI.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Sep 2001, Horst von Brand wrote:
[quote snipped]
> C's unsigned arithmetic is 2-complement. Never even seen a 1-complement
> machine.

CDC big iron.  Seymour Cray found he could get a little more speed out of
his design that way.  IIRC SPSS on CDC gear used the -0 value to indicate
a missing case.

-- 
Mark H. Wood, Lead System Programmer   mwood@IUPUI.Edu
Make a good day.

