Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbUCIB25 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 20:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbUCIB25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 20:28:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:18570 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261430AbUCIB24 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 20:28:56 -0500
Date: Mon, 8 Mar 2004 17:35:31 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Thomas Schlichter <thomas.schlichter@web.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix warning about duplicate 'const'
In-Reply-To: <Pine.LNX.4.58.0403081728250.9575@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0403081733290.9575@ppc970.osdl.org>
References: <200403090043.21043.thomas.schlichter@web.de>
 <20040308161410.49127bdf.akpm@osdl.org> <Pine.LNX.4.58.0403081627450.9575@ppc970.osdl.org>
 <200403090217.40867.thomas.schlichter@web.de> <Pine.LNX.4.58.0403081728250.9575@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Mar 2004, Linus Torvalds wrote:
> 
> All that code was from early 2002 (around 2.4.9), so maybe somebody can 
> find the full discussion on the linux-kernel archives from January 2002 or 
> so?

Duh. Make that August/September 2001 or something. My BK dates are off for 
the early 2.4.x series, since I imported those as patches in early 2002.

		Linus
