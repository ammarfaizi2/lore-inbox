Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262582AbVAPTwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262582AbVAPTwX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 14:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbVAPTtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 14:49:45 -0500
Received: from sycorax.lbl.gov ([128.3.5.196]:48313 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id S262600AbVAPTr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 14:47:56 -0500
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: pavel@ucw.cz, bernard@blackham.com.au, linux-kernel@vger.kernel.org,
       shawv@comcast.net
Subject: Re: Screwy clock after apm suspend
References: <200501151830.j0FIUnjR020458@harpo.it.uu.se>
From: Alex Romosan <romosan@sycorax.lbl.gov>
Date: Sun, 16 Jan 2005 11:47:25 -0800
In-Reply-To: <200501151830.j0FIUnjR020458@harpo.it.uu.se> (message from
 Mikael Pettersson on Sat, 15 Jan 2005 19:30:49 +0100 (MET))
Message-ID: <87mzv9i2b6.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> writes:

> I'm no longer seeing any time jumps after resumes with the
> 2.6.11-rc1 kernel. It looks like the wall_jiffies change in
> time.c fixed the bug.

i can also confirm the that the time no longer jumps after an acpi
resume with the 2.6.11-rc1 kernel.

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
