Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267350AbTALJuc>; Sun, 12 Jan 2003 04:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267349AbTALJuc>; Sun, 12 Jan 2003 04:50:32 -0500
Received: from tomts9.bellnexxia.net ([209.226.175.53]:54660 "EHLO
	tomts9-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S267350AbTALJuc>; Sun, 12 Jan 2003 04:50:32 -0500
Date: Sun, 12 Jan 2003 04:59:26 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Adrian Bunk <bunk@fs.tum.de>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: two more oddities with the fs/Kconfig file
In-Reply-To: <Pine.LNX.4.44.0301120449530.4974-100000@dell>
Message-ID: <Pine.LNX.4.44.0301120458190.5012-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jan 2003, Robert P. J. Day wrote:

> config UMSDOS_FS
> 	bool
> 	---help---

oh, never mind ... i was confused by what the above meant,
not realizing that i had inadvertantly removed the comment
above it that stated that it was broken.  argh.

rday

