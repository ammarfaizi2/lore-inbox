Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbUAOVrD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 16:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbUAOVrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 16:47:03 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:47633 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261735AbUAOVrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 16:47:01 -0500
Date: Thu, 15 Jan 2004 22:46:48 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Romain Lievin <romain@rlievin.dyndns.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ozan Eren Bilgen <oebilgen@uekae.tubitak.gov.tr>
Subject: Re: True story: "gconfig" removed root folder...
In-Reply-To: <20040115212304.GA25296@rlievin.dyndns.org>
Message-ID: <Pine.LNX.4.58.0401152245030.27223@serv>
References: <1074177405.3131.10.camel@oebilgen> <Pine.LNX.4.58.0401151558590.27223@serv>
 <20040115212304.GA25296@rlievin.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 15 Jan 2004, Romain Lievin wrote:

> I have managed to reproduce bug: make gconfig, go to the '/' directory,
> type 'root' as file and ... you get a 'root' file. The 'root' directory is
> destroyed !

What do you mean with "destroyed"? All I can reproduce here is that it's
simply moved away, but it's still there!

bye, Roman
