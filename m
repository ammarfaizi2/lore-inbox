Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266924AbSKUSFn>; Thu, 21 Nov 2002 13:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266928AbSKUSFn>; Thu, 21 Nov 2002 13:05:43 -0500
Received: from hera.cwi.nl ([192.16.191.8]:34984 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S266924AbSKUSFn>;
	Thu, 21 Nov 2002 13:05:43 -0500
From: Andries.Brouwer@cwi.nl
Date: Thu, 21 Nov 2002 19:12:10 +0100 (MET)
Message-Id: <UTC200211211812.gALICAX22119.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, viro@math.psu.edu
Subject: Re: kill i_dev
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Alexander Viro <viro@math.psu.edu>

    On Thu, 21 Nov 2002 Andries.Brouwer@cwi.nl wrote:

    > Yes, I looked at that but concluded that someone (you?)
    > had added the assignment just to preserve the guarantee
    > previously given by get_empty_inode() at the moment it
    > was replaced by new_inode(). But it is superfluous, I think.

    Existing userland doesn't, though.

I saw that you hit fuser last year, but this is 2.5.
Any other examples?
