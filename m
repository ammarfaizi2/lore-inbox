Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbVIJTPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbVIJTPP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 15:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbVIJTPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 15:15:15 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:34250 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750812AbVIJTPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 15:15:14 -0400
Date: Sat, 10 Sep 2005 21:15:07 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@mars.xs4all.nl>
Subject: Re: [PATCH 9/12] kbuild: mips use generic asm-offsets.h support
In-Reply-To: <11263057061465-git-send-email-sam@ravnborg.org>
Message-ID: <Pine.LNX.4.61.0509101949240.3743@scrub.home>
References: <11263057061465-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 10 Sep 2005, Sam Ravnborg wrote:

>  Kbuild                          |    9 ++++++++-

What's that file good for?
I know you want us to start using Kbuild, but Makefile works just 
fine and that's what everyone is used to.

bye, Roman
