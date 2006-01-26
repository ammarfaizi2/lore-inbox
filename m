Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbWAZTBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWAZTBf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 14:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbWAZTBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 14:01:34 -0500
Received: from mail.gmx.net ([213.165.64.21]:12685 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964806AbWAZTBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 14:01:34 -0500
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc1-mm3 (psmouse.c)
Date: Thu, 26 Jan 2006 20:01:30 +0100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
References: <20060124232406.50abccd1.akpm@osdl.org>
In-Reply-To: <20060124232406.50abccd1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601262001.30630.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 25. January 2006 08:24, Andrew Morton wrote:
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2
>.6.16-rc1-mm3/

hi!
Since 2.6.16-rc1-mm2 I very often get this message in dmesg:

psmouse.c: bad data from KBC - timeout

And my whole system freezes (cause music stops playing too) then for a few 
seconds (about 10-20s). As I didn't had such problems before, I think it's 
-mm related since 2.6.16-rc1-mm2.

dominik
