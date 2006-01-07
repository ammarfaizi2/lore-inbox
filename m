Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030272AbWAGAzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbWAGAzG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 19:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbWAGAzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 19:55:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12761 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030302AbWAGAzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 19:55:04 -0500
Date: Fri, 6 Jan 2006 19:54:49 -0500
From: Dave Jones <davej@redhat.com>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-git2: CONFIGFS_FS shows up as M/y choice, help says "if unsure, say N"
Message-ID: <20060107005449.GE9402@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alessandro Suardi <alessandro.suardi@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <5a4c581d0601061310j3f4eb310o1d68c0b87c278685@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a4c581d0601061310j3f4eb310o1d68c0b87c278685@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 10:10:13PM +0100, Alessandro Suardi wrote:
 > ===========
 > Userspace-driven configuration filesystem (EXPERIMENTAL) (CONFIGFS_FS)
 > [M/y/?] (NEW)
 > 
 > Both sysfs and configfs can and should exist together on the
 > same system. One is not a replacement for the other.
 > 
 > If unsure, say N.
 > ===========
 > 
 > I think I'll say M - for now ;)

If you turn of 'OCFS2', then you'll be able to deselect configfs.

		Dave
