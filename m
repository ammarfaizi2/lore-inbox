Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131459AbRAKRjT>; Thu, 11 Jan 2001 12:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131452AbRAKRjJ>; Thu, 11 Jan 2001 12:39:09 -0500
Received: from zero.tech9.net ([209.61.188.187]:516 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S130382AbRAKRjA>;
	Thu, 11 Jan 2001 12:39:00 -0500
Date: Thu, 11 Jan 2001 12:38:57 -0500 (EST)
From: "Robert M. Love" <rml@tech9.net>
To: Giacomo Catenazzi <cate@student.ethz.ch>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Compile error: DRM without AGP in 2.4.0
In-Reply-To: <3A5DEA5D.B783B323@student.ethz.ch>
Message-ID: <Pine.LNX.4.30.0101111238210.1732-100000@phantasy.awol.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2001, Giacomo Catenazzi spoke:
> Here a valid configuration (no AGP, but all DRM set)
> compiling [2.4.0]:
> [...]

DRM requires AGPGART.

-- 
Robert M. Love
rml@ufl.edu
rml@tech9.net

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
