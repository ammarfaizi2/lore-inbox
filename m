Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129798AbRB0T7B>; Tue, 27 Feb 2001 14:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129807AbRB0T6w>; Tue, 27 Feb 2001 14:58:52 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:16417 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S129798AbRB0T6k>;
	Tue, 27 Feb 2001 14:58:40 -0500
Message-ID: <20010227205837.A18843@win.tue.nl>
Date: Tue, 27 Feb 2001 20:58:37 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: "H. Peter Anvin" <hpa@transmeta.com>,
        Mack Stevenson <mackstevenson@hotmail.com>
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: ISO-8859-1 completeness of kernel fonts?
In-Reply-To: <F110arjrfh6BYVKBLEB00013ccb@hotmail.com> <3A9BE5F3.780B24AE@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3A9BE5F3.780B24AE@transmeta.com>; from H. Peter Anvin on Tue, Feb 27, 2001 at 09:37:55AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2001 at 09:37:55AM -0800, H. Peter Anvin wrote:

> You're much better off designing a larger ISO-8859-1 font and load in in
> user space.  You can use the 12x22 font in the kernel as a base.

kbd-1.05 comes with sun12x22.psfu, which essentially is the kernel font
together with a unimap.

Andries
