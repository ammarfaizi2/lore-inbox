Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264490AbTCXW26>; Mon, 24 Mar 2003 17:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264491AbTCXW26>; Mon, 24 Mar 2003 17:28:58 -0500
Received: from hera.cwi.nl ([192.16.191.8]:34756 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S264490AbTCXW25>;
	Mon, 24 Mar 2003 17:28:57 -0500
From: Andries.Brouwer@cwi.nl
Date: Mon, 24 Mar 2003 23:40:04 +0100 (MET)
Message-Id: <UTC200303242240.h2OMe4Z24484.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, zippel@linux-m68k.org
Subject: Re: [PATCH 1/3] revert register_chrdev_region change
Cc: akpm@digeo.com, hch@infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > > I still don't know what we need ranges or even subranges for.
    > > What problem are you trying to solve?
    > 
    > I mentioned the structure of Al's block device code to you.
    > Haven't you read blk_register_region()?

    I did, have you seen add_disk()? ...
    So which problem requires a complex (sub)ranges solution?

Roman, please. There is no need to invent discussions.
Al wrote certain code. It is not my code. I mentioned
that this code has certain properties.

If you want to know why Al wrote the code he wrote, ask him.

Andries
