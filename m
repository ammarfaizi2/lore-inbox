Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290127AbSAXUQU>; Thu, 24 Jan 2002 15:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290138AbSAXUQL>; Thu, 24 Jan 2002 15:16:11 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:33719 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S290127AbSAXUP7>;
	Thu, 24 Jan 2002 15:15:59 -0500
Date: Thu, 24 Jan 2002 15:15:56 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Oliver Xymoron <oxymoron@waste.org>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: RFC: booleans and the kernel
In-Reply-To: <3C50688B.E87B421F@mandrakesoft.com>
Message-ID: <Pine.GSO.4.21.0201241511260.21209-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 24 Jan 2002, Jeff Garzik wrote:

> If one tests X==false and then later on tests X==true,

... one is a wanker.  (X == false) is not idiomatic. (!X) is.

