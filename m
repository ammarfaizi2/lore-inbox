Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267794AbTAHJzc>; Wed, 8 Jan 2003 04:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267796AbTAHJzc>; Wed, 8 Jan 2003 04:55:32 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:11620 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S267794AbTAHJzb>; Wed, 8 Jan 2003 04:55:31 -0500
Date: Wed, 8 Jan 2003 11:03:37 +0100 (CET)
From: bart@etpmod.phys.tue.nl
Reply-To: bart@etpmod.phys.tue.nl
Subject: Re: Undelete files on ext3 ??
To: root@chaos.analogic.com
Cc: maxvaldez@yahoo.com, bulb@ucw.cz, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Message-Id: <20030108100339.06D8C52BB1@gum12.etpnet.phys.tue.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  7 Jan, Richard B. Johnson wrote:

> 
> tell it to 'really' delete a file (or is there?). So,
> maybe we need a new kernel function? Just hacking existing
> utilities won't do the whole thing because we need programs
> that delete files to transparently put them into the
> dumpster as well.

I think libc would be the best place to implement such a thing. 

Bart


-- 
Bart Hartgers - TUE Eindhoven 
http://plasimo.phys.tue.nl/bart/contact.html
