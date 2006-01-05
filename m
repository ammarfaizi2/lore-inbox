Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751872AbWAERnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbWAERnc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 12:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbWAERnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 12:43:32 -0500
Received: from gate.crashing.org ([63.228.1.57]:36831 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751872AbWAERnb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 12:43:31 -0500
Date: Thu, 5 Jan 2006 11:37:33 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm1
In-Reply-To: <20060105062249.4bc94697.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0601051135100.1019-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm1/
> 
> 
> - ppc32 builds are broken

Do you have build logs somewhere for this.  I've got one patch that 
address a build failure for ppc32, however I need to get with BenH to 
figure out he considers pmac CONFIG_BROKEN for ARCH=ppc and that everyone 
should use ARCH=powerpc for it.

- kumar

