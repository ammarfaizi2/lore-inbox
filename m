Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267534AbTACOpr>; Fri, 3 Jan 2003 09:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267535AbTACOpr>; Fri, 3 Jan 2003 09:45:47 -0500
Received: from itg-gw.cr008.cwt.esat.net ([193.120.242.226]:35343 "EHLO
	dunlop.admin.ie.alphyra.com") by vger.kernel.org with ESMTP
	id <S267534AbTACOpp>; Fri, 3 Jan 2003 09:45:45 -0500
Date: Fri, 3 Jan 2003 14:52:29 +0000 (GMT)
From: Paul Jakma <paulj@alphyra.ie>
X-X-Sender: paulj@dunlop.admin.ie.alphyra.com
To: Rik van Riel <riel@conectiva.com.br>
cc: Richard Stallman <rms@gnu.org>, <mark@mark.mielke.cc>,
       <billh@gnuppy.monkey.org>, <paul@clubi.ie>, <Hell.Surfers@cwctv.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Why is Nvidia given GPL'd code to use in closed source drivers?
In-Reply-To: <Pine.LNX.4.50L.0301030838270.2429-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44.0301031449390.32195-100000@dunlop.admin.ie.alphyra.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jan 2003, Rik van Riel wrote:

> IMHO such freedom should leave the option of not having free drivers
> to companies like Nvidia.

Indeed, so why not add an exemption into the kernel's licence for 
binary only modules that only use module exported interfaces? The 
FSF's FAQ on the GPL even covers this.

that would remove the whole "is it a derived work?" grey area we're 
talking about.

> Have some faith in freedom, Richard...

good call.

but make it explicit in the kernel's licence.

> Rik

regards,
-- 
Paul Jakma	Sys Admin	Alphyra
	paulj@alphyra.ie
Warning: /never/ send email to spam@dishone.st or trap@dishone.st

