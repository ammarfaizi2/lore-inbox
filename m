Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264228AbTEGUbz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 16:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264271AbTEGUbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 16:31:55 -0400
Received: from [217.157.19.70] ([217.157.19.70]:64524 "EHLO jehova.dsm.dk")
	by vger.kernel.org with ESMTP id S264228AbTEGUbZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 16:31:25 -0400
From: Thomas Horsten <thomas@horsten.com>
To: Ken Witherow <ken@krwtech.com>
Subject: Re: [PATCH] 2.5.69 Changes to Kconfig and i386 Makefile to include support for various K7 optimizations
Date: Wed, 7 May 2003 21:44:09 +0100
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.40.0305072126450.30616-100000@jehova.dsm.dk> <Pine.LNX.4.55.0305071605590.709@death>
In-Reply-To: <Pine.LNX.4.55.0305071605590.709@death>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305072144.09356.thomas@horsten.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 May 2003 21:06, Ken Witherow wrote:
> > +config K7_ATHLONMP
> > +	bool "Athlon MP"
> > +	help
> > +	  Select this if you have an Athlon XP CPU, to enable optimizations
> > +	  specific to that processor.
>
> I do believe Athlon XP when you mean MP is a copy/paste typo :)

You are right, thanks for spotting this :)

I'll fix this and re-post it when I have some more feedback.

// Thomas

