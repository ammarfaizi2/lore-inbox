Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316158AbSFUCIl>; Thu, 20 Jun 2002 22:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316161AbSFUCIk>; Thu, 20 Jun 2002 22:08:40 -0400
Received: from beach.cise.ufl.edu ([128.227.205.211]:58278 "EHLO
	mail.cise.ufl.edu") by vger.kernel.org with ESMTP
	id <S316158AbSFUCIk>; Thu, 20 Jun 2002 22:08:40 -0400
Date: Thu, 20 Jun 2002 22:08:40 -0400 (EDT)
From: Pradeep Padala <ppadala@cise.ufl.edu>
To: Robert Love <rml@ufl.edu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ptrace vs /proc
In-Reply-To: <1024609747.922.0.camel@sinai>
Message-ID: <Pine.GSO.4.33.0206202205100.2178-100000@rain.cise.ufl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There is no such interface in Linux and currently no plans to develop a
> Solaris-style /proc.

I would like to develop such interface. Is it Ok if I go ahead and send a
patch. I have been playing with ptrace in the kernel for a while.

> Some work that may go into 2.5, task ornaments, may facilitate easier
> debugging and perhaps make such a /proc more feasible in the future.

What are task ornaments? Can you elaborate on this?

TIA
--pradeep

