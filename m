Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262987AbVBCOyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262987AbVBCOyv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 09:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263456AbVBCOtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 09:49:20 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:52427 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S263495AbVBCOj6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 09:39:58 -0500
Date: Thu, 3 Feb 2005 15:39:47 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Peter Busser <busser@m-privacy.de>
cc: pageexec@freemail.hu, linux-kernel@vger.kernel.org
Subject: Re: Sabotaged PaXtest (was: Re: Patch 4/6  randomize the stack
 pointer)
In-Reply-To: <200502031455.22100.busser@m-privacy.de>
Message-ID: <Pine.LNX.4.61.0502031537410.6118@scrub.home>
References: <4201DBE7.30569.2F5D446@localhost> <200502031455.22100.busser@m-privacy.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 3 Feb 2005, Peter Busser wrote:

> - What happens when you run existing commercial applications which have not 
> been compiled using GCC.

>From http://pax.grsecurity.net/docs/pax.txt:

   The goal of the PaX project is to research various defense mechanisms
   against the exploitation of software bugs that give an attacker arbitrary
   read/write access to the attacked task's address space. 

Could you please explain how PaX makes such applications secure?

bye, Roman
