Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262928AbVAFRfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262928AbVAFRfd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 12:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262926AbVAFRej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 12:34:39 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:38075 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262928AbVAFRe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 12:34:29 -0500
Subject: Re: [patch 6/6] delete unused file
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matt Mackall <mpm@selenic.com>
Cc: domen@coderock.org, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050104210342.GA2995@waste.org>
References: <20041226153257.0F3501F126@trashy.coderock.org>
	 <1104081178.15994.11.camel@localhost.localdomain>
	 <20050104210342.GA2995@waste.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105020583.17166.208.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 06 Jan 2005 16:30:04 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-01-04 at 21:03, Matt Mackall wrote:
> On Sun, Dec 26, 2004 at 05:13:00PM +0000, Alan Cox wrote:
> > On Sul, 2004-12-26 at 15:33, domen@coderock.org wrote:
> > > Remove nowhere referenced file. (egrep "filename\." didn't find anything)
> > 
> > This file is there for a reason - it completes the set of endian types
> > should anyone port to a mixed endian system.
> 
> Please name one such box that doesn't support a more sensible order
> and is vaguely Linux-capable.

That isnt the point of having a neat set of complete headers sometimes.

Alan

