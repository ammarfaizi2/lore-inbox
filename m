Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285423AbRLGGIW>; Fri, 7 Dec 2001 01:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285424AbRLGGIM>; Fri, 7 Dec 2001 01:08:12 -0500
Received: from ns.crrstv.net ([216.94.219.4]:19149 "EHLO mail.crrstv.net")
	by vger.kernel.org with ESMTP id <S285423AbRLGGIC>;
	Fri, 7 Dec 2001 01:08:02 -0500
Date: Fri, 7 Dec 2001 02:07:44 -0400 (AST)
From: skidley <skidley@crrstv.net>
X-X-Sender: <skidley@localhost.localdomain>
To: <devnull@geisel.info>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17-pre5 "make bzImage" fails
In-Reply-To: <20011206195702.GA12755@geisel.info>
Message-ID: <Pine.LNX.4.33L2.0112070206360.2900-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2001 devnull@geisel.info wrote:

> On Thu, Dec 06, 2001 at 02:53:16PM -0500, Jeff Garzik wrote:
> > did you upgrade your binutils recently?
>
> Yes, I upgraded to binutils-2.11.92.0.7-3mdk from Mandrake cooker today.
>
That's the problem I had same version. I did rpm -Uvh --oldpackage of the
old versions of binutils, libbinutils and it compiled fine
-- 
Chad Young
Registered Linux User #195191 @ http://counter.li.org

