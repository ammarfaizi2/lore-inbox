Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265043AbRFVB1v>; Thu, 21 Jun 2001 21:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265214AbRFVB1l>; Thu, 21 Jun 2001 21:27:41 -0400
Received: from noc242.toshiba-eng.co.jp ([210.254.22.242]:37047 "EHLO
	noc4.toshiba-eng.co.jp") by vger.kernel.org with ESMTP
	id <S265043AbRFVB1a>; Thu, 21 Jun 2001 21:27:30 -0400
Date: Fri, 22 Jun 2001 10:27:16 +0900
From: Masaru Kawashima <masaru@scji.toshiba-eng.co.jp>
To: John Madden <jmadden@ivy.tec.in.us>
Cc: linux-kernel@vger.kernel.org, "Andrey V. Savochkin" <saw@saw.sw.com.sg>
Subject: Re: eepro100: wait_for_cmd_done timeout
Message-Id: <20010622102716.7db7bd4d.masaru@scji.toshiba-eng.co.jp>
In-Reply-To: <0106210940470C.28098@ycn013>
In-Reply-To: <20010620163134.A22173@technolunatic.com>
	<20010621231939.757bddd6.masaru@scji.toshiba-eng.co.jp>
	<0106210940470C.28098@ycn013>
X-Mailer: Sylpheed version 0.4.66 (GTK+ 1.2.7; i686-pc-linux-gnu)
Organization: Open Software Sec.  TOSHIBA ENGINEERING Corp.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2001 09:37:47 -0500
John Madden <jmadden@ivy.tec.in.us> wrote:
> errors.  Think the patch with the udelay() will still work?

In my system, the patch with the udelay() is working.

--
Masaru Kawashima
