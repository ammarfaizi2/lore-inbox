Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263184AbUEWRdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263184AbUEWRdH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 13:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbUEWRdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 13:33:07 -0400
Received: from smtp-out6.xs4all.nl ([194.109.24.7]:61448 "EHLO
	smtp-out6.xs4all.nl") by vger.kernel.org with ESMTP id S263184AbUEWRdE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 13:33:04 -0400
Date: Sun, 23 May 2004 19:32:50 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.local
To: Linus Torvalds <torvalds@osdl.org>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Explicitly documenting patch submission 
In-Reply-To: <Pine.LNX.4.58.0405230955580.25502@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0405231925120.10292@scrub.local>
References: <200405231633.i4NGXHv18935@pincoya.inf.utfsm.cl>
 <Pine.LNX.4.58.0405230955580.25502@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 23 May 2004, Linus Torvalds wrote:

> The path _inside_ BK is different - BK won't update the changelog 
> comments, so basically once it hits BK (or any other SCM, for that 
> matter), it's up to the SCM to save off the path details. BK does this by 
> recording who committed something, and recording merges, so the 
> information still exists, but it's no longer in the same format.

Then it's also no longer public information, the information about empty 
merges is not available via bkweb or the cvs gateway.

bye, Roman
