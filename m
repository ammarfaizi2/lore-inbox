Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265174AbSKNR6A>; Thu, 14 Nov 2002 12:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265177AbSKNR6A>; Thu, 14 Nov 2002 12:58:00 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:41126 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S265174AbSKNR57>;
	Thu, 14 Nov 2002 12:57:59 -0500
Date: Thu, 14 Nov 2002 13:04:51 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] devfs API
In-Reply-To: <200211141751.gAEHpAVm021359@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0211141258561.12789-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Nov 2002, Richard Gooch wrote:

> - I'm leery of changing the API and breaking compatibility between 2.4
>   and 2.5 drivers. I also don't want to break out-of-tree drivers
>   without giving maintainers plenty of warning. There are a number
>   such out there

It's a bit late for that.  Compatibility between 2.4 and 2.5 in the
drivers is already broken and devfs won't be anywhere near the top of
the list.

