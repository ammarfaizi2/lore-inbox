Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266095AbTAUHBU>; Tue, 21 Jan 2003 02:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266200AbTAUHBU>; Tue, 21 Jan 2003 02:01:20 -0500
Received: from dhcp34.trinity.linux.conf.au ([130.95.169.34]:16256 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id <S266095AbTAUHBT>; Tue, 21 Jan 2003 02:01:19 -0500
Subject: Re: [PATCH] 2.4.21-pre3-ac oops
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bryan Andersen <bryan@bogonomicon.net>
Cc: Hugh Dickins <hugh@veritas.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E2B1833.5060203@bogonomicon.net>
References: <Pine.LNX.4.44.0301191347310.2280-100000@localhost.localdomain>
	 <3E2B1833.5060203@bogonomicon.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043051859.12098.24.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 20 Jan 2003 08:37:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-19 at 21:27, Bryan Andersen wrote:
> Nothing seams to come of them, but in the average boot I see
> 25 or so of them.  They did not show up under linux-2.4.21-pre3.
> As near as I can tell they are generated when an ide device is
> closed.

Its short term debugging. 

