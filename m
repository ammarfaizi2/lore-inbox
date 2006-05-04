Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030330AbWEDVeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030330AbWEDVeL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 17:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030331AbWEDVeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 17:34:11 -0400
Received: from web.bloglines.com ([65.214.39.152]:42712 "HELO
	blw10.io.askjeeves.info") by vger.kernel.org with SMTP
	id S1030330AbWEDVeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 17:34:10 -0400
Message-ID: <1146778449.2205721908.4856.sendItem@bloglines.com>
Date: 4 May 2006 21:34:09 -0000
From: grfgguvf.29601511@bloglines.com
To: Valdis.Kletnieks@vt.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: Weird framebuffer bug? 
MIME-Version: 1.0
Content-Type: text/plain;charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Valdis.Kletnieks@vt.edu wrote:
> I'll bite.  Have you tried using a configuration
that specifies the *actual*
> LCD resolution so it doesn't have to interpolate?
 It could be that the
> interpolation hardware is buggy.

Both vesafb and
X (with fbdev and nv too) are set to 1024x768 which is the actual resolution.
