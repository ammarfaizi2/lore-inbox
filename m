Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265506AbSK1N1X>; Thu, 28 Nov 2002 08:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265508AbSK1N1X>; Thu, 28 Nov 2002 08:27:23 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:53386 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S265506AbSK1N1W>;
	Thu, 28 Nov 2002 08:27:22 -0500
Date: Thu, 28 Nov 2002 14:34:39 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Thomas Molina <tmolina@copper.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] README change
Message-ID: <20021128133439.GA5795@win.tue.nl>
References: <1038443167.2063.28.camel@lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1038443167.2063.28.camel@lap>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2002 at 06:26:05PM -0600, Thomas Molina wrote:

-   Do NOT use the /usr/src/linux area! This area has a (usually
-   incomplete) set of kernel headers that are used by the library header
-   files.  They should match the library, and not get messed up by
-   whatever the kernel-du-jour happens to be.
+   Do NOT use /usr/src/linux! This directory should contain the source
+   and headers of the kernel gcc was compile with.  They should match 
+   the compiler, and not get messed up by whatever the kernel-du-jour
+   happens to be.

The original text was not bad.
The new text is completely wrong.
