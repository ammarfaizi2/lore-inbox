Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265902AbUGHJff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265902AbUGHJff (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 05:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265939AbUGHJff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 05:35:35 -0400
Received: from magic.adaptec.com ([216.52.22.17]:10642 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S265902AbUGHJf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 05:35:26 -0400
Date: Thu, 8 Jul 2004 15:07:29 +0530 (IST)
From: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
X-X-Sender: tomar@localhost.localdomain
Reply-To: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>
To: Rik van Riel <riel@redhat.com>
cc: Justin Piszcz <jpiszcz@lucidpixels.com>, <linux-kernel@vger.kernel.org>,
       <justin.piszcz@mitretek.org>
Subject: Re: Does Optimization Effect BogoMips Value?
In-Reply-To: <Pine.LNX.4.44.0407071345420.20572-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.44.0407081506270.6113-100000@localhost.localdomain>
Organization: Adaptec
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 08 Jul 2004 09:35:21.0217 (UTC) FILETIME=[E3446F10:01C464CE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jul 2004, Rik van Riel wrote:

> On Wed, 7 Jul 2004, Justin Piszcz wrote:
> 
> > Three identical Virtual Machines with three different compiler flags to
> > compile the entire distribution, in this case, Gentoo 2004.1.
> > 
> > However, why are the Bogomips values different (up to +82 points
> > different)?
> 
> It really doesn't matter for performance. A higher
> bogomips value just means the system will spin more
> delay loops to wait the same amount of time...


If it can spin more delay loops in the same time, then probably it can do 
more useful work also in the same time.


> 
> For more details, see http://funroll-loops.org/
> 
> 

-- 



-- You have moved the mouse. Windows must be restarted for the 
   changes to take effect.

