Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265804AbUE1E0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265804AbUE1E0f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 00:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265800AbUE1E0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 00:26:31 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:2525 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S265794AbUE1E0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 00:26:30 -0400
Date: Fri, 28 May 2004 00:21:19 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: ftp.kernel.org
In-Reply-To: <1130000.1085711344@[10.10.2.4]>
Message-ID: <Pine.GSO.4.33.0405280018250.14297-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2004, Martin J. Bligh wrote:
>They switched to vsftpd very recently ... presumably then.

That would explain it.  The default is to turn it off.

>Why would you mirror via ftp, instead of rsync anyway?

I have more control with mirror.  And I've been using mirror for
*ahem* a decade.  I've been using rsync for mirroring debian, but
it's slow and often fails to complete.  Mirror has never let me
down ('tho it has deleted entire archives before *grin*)

--Ricky


