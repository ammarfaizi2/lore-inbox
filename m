Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422696AbVLOMAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422696AbVLOMAt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 07:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422670AbVLOMAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 07:00:48 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:12008 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965165AbVLOMAr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 07:00:47 -0500
Date: Thu, 15 Dec 2005 13:00:05 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Al Viro <viro@ftp.linux.org.uk>
cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-m68k@vger.kernel.org
Subject: Re: [PATCH 2/3] m68k: compile fix - ADBREQ_RAW missing declaration
In-Reply-To: <20051215085516.GU27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.61.0512151258200.1605@scrub.home>
References: <20051215085516.GU27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 15 Dec 2005, Al Viro wrote:

> another compile fix, pulled straight from m68k CVS

Thanks, but if you pull changes out of CVS could you please keep the 
author intact? CVS may be bad, but it's not that bad.

bye, Roman
