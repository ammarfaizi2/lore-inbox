Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964976AbWEaMdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbWEaMdE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 08:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbWEaMdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 08:33:04 -0400
Received: from vena.lwn.net ([206.168.112.25]:6313 "HELO lwn.net")
	by vger.kernel.org with SMTP id S964976AbWEaMdD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 08:33:03 -0400
Message-ID: <20060531123303.9581.qmail@lwn.net>
To: "Brian D. McGrew" <brian@visionpro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sharing memory between kernel and user space 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Tue, 30 May 2006 15:53:14 PDT."
             <14CFC56C96D8554AA0B8969DB825FEA0012B331D@chicken.machinevisionproducts.com> 
Date: Wed, 31 May 2006 06:33:03 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm using the 2.6.16.16 kernel.  Is there any chance that I could
> trouble you for a snippet of code to do that?  I've tried every
> combination I can think of.

The memory mapping chapter of LDD3 (http://lwn.net/Kernel/LDD3/) has a
pretty thorough description of how to share both kernel- and user-space
memory, with code examples.

jon
