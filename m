Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262522AbULDCOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbULDCOB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 21:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbULDCOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 21:14:01 -0500
Received: from linaeum.absolutedigital.net ([63.87.232.45]:12699 "EHLO
	linaeum.absolutedigital.net") by vger.kernel.org with ESMTP
	id S262522AbULDCNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 21:13:52 -0500
Date: Fri, 3 Dec 2004 21:13:57 -0500 (EST)
From: Cal Peake <cp@absolutedigital.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-ac13
In-Reply-To: <1102096309.10714.1.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0412032110220.12957@linaeum.absolutedigital.net>
References: <1102096309.10714.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Dec 2004, Alan Cox wrote:

> This -ac is a little different. It's still an experimental -ac to test the 
> accumulated patches it would be nice to have in -ac but which might break
> something and seemed too risky. As such please test it but in general wait
> for the next -ac before planning to update production systems.

Alan, you forgot to update your Makefile:

VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 9
EXTRAVERSION = -ac12 <---
NAME=AC 1

-- Cal

