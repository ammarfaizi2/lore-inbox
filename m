Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbWAKS3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWAKS3Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 13:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWAKS3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 13:29:24 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:174 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964788AbWAKS3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 13:29:23 -0500
Subject: Re: Kernel 2.6.15 sometimes only detects one of two SATA drives
	and panics
From: Lee Revell <rlrevell@joe-job.com>
To: Andre Hessling <ahessling@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1137003241.7603.20.camel@localhost.localdomain>
References: <1137003241.7603.20.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 13:29:21 -0500
Message-Id: <1137004161.27255.72.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 19:14 +0100, Andre Hessling wrote:
> Hello!
> 
> I recently upgraded from 2.6.14 to 2.6.15 vanilla and I encountered some
> random kernel panics on boot so far.
> 
> The panic is:
> "Kernel panic: VFS: Unable to mount root fs on unknown-block(0,0)"
> 
> My config hasn't changed since 2.6.14 and I never encountered such an
> error under 2.6.14.
> 

Check your cabling and termination.

Lee

