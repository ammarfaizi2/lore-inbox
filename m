Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316964AbSFZWCw>; Wed, 26 Jun 2002 18:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316965AbSFZWCv>; Wed, 26 Jun 2002 18:02:51 -0400
Received: from plogic.com ([209.92.41.135]:60907 "EHLO otto.plogic.internal")
	by vger.kernel.org with ESMTP id <S316964AbSFZWCu>;
	Wed, 26 Jun 2002 18:02:50 -0400
Date: Wed, 26 Jun 2002 18:02:03 -0400 (EDT)
From: Dan Sturtevant <dsturtev@plogic.com>
X-X-Sender: dsturtev@milhouse.plogic.internal
To: linux-kernel@vger.kernel.org
Subject: x86 Page Sizes
Message-ID: <Pine.LNX.4.44.0206261759230.11230-100000@milhouse.plogic.internal>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I know the x86 linux kernel has 4K pages in userspace and 4M pages in 
kernel space.  These two sizes seem to be limitations of the intel 
architecture (I think).

Does anyone know a way to increase the userspace page size above 4K?
Are there any patches for a 4M userspace pagesize?

Thanks,
Dan

