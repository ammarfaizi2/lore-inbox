Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbVBXCYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbVBXCYf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 21:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVBXCYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 21:24:32 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:21475 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261681AbVBXCYb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 21:24:31 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Martin =?iso-8859-2?q?MOKREJ=A9?= 
	<mmokrejs@ribosome.natur.cuni.cz>
Subject: Re: memory management weirdness
Date: Wed, 23 Feb 2005 21:24:15 -0500
User-Agent: KMail/1.7.92
Cc: LKML <linux-kernel@vger.kernel.org>
References: <022120051420.20884.4219EE21000C6C9400005194220588448400009A9B9CD3040A029D0A05@comcast.net> <421B0224.1050509@ribosome.natur.cuni.cz>
In-Reply-To: <421B0224.1050509@ribosome.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200502232124.15942.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 February 2005 04:57 am, Martin MOKREJ© wrote:
> The 3GB labeled file corresponds to fast case, 4GB is ugly slow.
> What can you gather from those files?
I did take a look and didn't analyze it further since Andi Mentioned it is a 
known BIOS bug.
Sorry about the trouble - didn't imagine it might be  BIOS related. Generally 
speaking it helps to have profile available when things are going slow.

Parag
