Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316408AbSHJAmY>; Fri, 9 Aug 2002 20:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316430AbSHJAmY>; Fri, 9 Aug 2002 20:42:24 -0400
Received: from main.tellink.net ([208.3.160.2]:13297 "EHLO main.tellink.net")
	by vger.kernel.org with ESMTP id <S316408AbSHJAmX>;
	Fri, 9 Aug 2002 20:42:23 -0400
Date: Fri, 9 Aug 2002 20:45:59 -0400 (EDT)
From: Jon Portnoy <portnoy@tellink.net>
X-X-Sender: portnoy@localhost.localdomain
To: Oliver Neukum <oliver@neukum.name>
cc: linux-kernel@vger.kernel.org
Subject: Re: HFS cleanup #1 - remove partition code
In-Reply-To: <200208100134.54011.oliver@neukum.name>
Message-ID: <Pine.LNX.4.44.0208092044440.4638-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd say that it's pretty important for compatibility with HFS-formatted 
devices such as CDROMs.

On Sat, 10 Aug 2002, Oliver Neukum wrote:

> Hi,
> 
> this removes the independent partition code from hfs.
> This is the first patch taking an axe to hfs so it'll be in shape for 2.6.
> Does anybody object to it being sent to Linus ?
> 
> 	Regards
> 		Oliver
> 

