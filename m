Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbUKWOND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbUKWOND (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 09:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbUKWODp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 09:03:45 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:2688 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261256AbUKWOCX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 09:02:23 -0500
Date: Tue, 23 Nov 2004 15:02:18 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: colin <colin@realtek.com.tw>
cc: linux-kernel@vger.kernel.org
Subject: Re: I cannot stop execution by using "ctrl+c"
In-Reply-To: <011501c4d14e$d00b1ce0$8b1a13ac@realtek.com.tw>
Message-ID: <Pine.LNX.4.53.0411231502030.28979@yvahk01.tjqt.qr>
References: <011501c4d14e$d00b1ce0$8b1a13ac@realtek.com.tw>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=big5
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi all,
>When using gdb to debug Linux kernel, I found that it cannot be stopped
>temporarily by using "ctrl+c".
>After the first strike of "ctrl+c", nothing happen.
>After the second, Linux kernel will show these messages:
>    Interrupted while waiting for the program.
>    Give up (and stop debugging it)? (y or n)
>If choose yes, kernel will totally stop and it goes back to gdb shell.
>How can I stop kernel temporarily and then resume it?

Since when does GDB *run* the kernel, if, well, the Kernel runs itself?


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
