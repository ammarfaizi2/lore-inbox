Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbTJJPiS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 11:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262944AbTJJPiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 11:38:18 -0400
Received: from mail.skjellin.no ([80.239.42.67]:11977 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S262942AbTJJPiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 11:38:17 -0400
Subject: Re: nforce2 unknown memory device
From: Andre Tomt <andre@tomt.net>
To: Gregor Burger <gregor.burger@aon.at>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200310101625.57372.gregor.burger@aon.at>
References: <200310101625.57372.gregor.burger@aon.at>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1065800065.574.1.camel@slurv>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 10 Oct 2003 17:34:25 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-10-10 at 16:25, Gregor Burger wrote:
> i tried to switch the memory sticks but nothing. when i install 1024 MB 
> ram linux detects 1008; with 512 i get 502.

Some chipsets with built-in VGA reserve a certain amount of system
memory for graphics memory.

> the xserver can't init agp with the error xf86_ENOMEM; but i think this
> is a couse of the missing memory that is not detected.

No idea.

-- 
Mvh,
André Tomt
andre@tomt.net

