Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264283AbVBFDyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264283AbVBFDyg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 22:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVBFDyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 22:54:35 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:6806 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262600AbVBFDya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 22:54:30 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: trelane@digitasaru.net
Subject: Re: Problem with trackpad and 2.6.11-rc[23], but not -rc1
Date: Sat, 5 Feb 2005 22:54:27 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <20050206021437.GA14715@digitasaru.net>
In-Reply-To: <20050206021437.GA14715@digitasaru.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502052254.28269.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 February 2005 21:14, Joseph Pingenot wrote:
> Hello.
> 
> I just tried (again) to get the most recent kernel version working on my
>   laptop.  All is clear except for one small detail: the trackpad and mouse
>   buttons don't work.  When using the eraser mouse, it moves around fine.
>   When using the trackpad, the cursour jumps around as though it were using
>   the wrong protocol.  Additionally, the mousebuttons either have no effect
>   or cause the mouse to suddenly jump left.  The kernel log has tons of error
>   messages (attached).
> This behavior started occurring in 2.6.11-rc2; it works fine in 2.6.11-rc1.
>   The behaviour here was listed with software suspend 2, but when I was
>   testing it with -rc2, no software suspend patches were applied and I still
>   saw the behavior.

What kind of touchpad? What does /proc/bus/input/devices show?

-- 
Dmitry
