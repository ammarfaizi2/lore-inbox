Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271741AbRJPXRo>; Tue, 16 Oct 2001 19:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271800AbRJPXRe>; Tue, 16 Oct 2001 19:17:34 -0400
Received: from femail5.sdc1.sfba.home.com ([24.0.95.85]:42996 "EHLO
	femail5.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S271741AbRJPXRX>; Tue, 16 Oct 2001 19:17:23 -0400
Date: Tue, 16 Oct 2001 19:14:48 -0400
From: Willem Riede <wriede@home.com>
To: linux-kernel@vger.kernel.org
Subject: Radeon driver in 2.4.10ac12
Message-ID: <20011016191448.A1427@linnie.riede.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.2.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since I upgraded to 2.4.10ac12 I find these messages in my log:

Oct 14 00:46:59 linnie kernel: [drm:radeon_freelist_get] *ERROR* returning
NULL!
Oct 14 00:48:37 linnie last message repeated 3 times
Oct 14 00:50:40 linnie last message repeated 2 times
Oct 14 00:51:54 linnie last message repeated 4 times
Oct 14 00:53:14 linnie kernel: [drm:radeon_freelist_get] *ERROR* returning
NULL!
Oct 14 00:56:33 linnie last message repeated 3 times
Oct 15 00:04:03 linnie kernel: [drm:radeon_freelist_get] *ERROR* returning
NULL!
Oct 15 00:04:47 linnie kernel: [drm:radeon_freelist_get] *ERROR* returning
NULL!
Oct 15 00:06:34 linnie last message repeated 3 times
Oct 15 00:08:22 linnie last message repeated 3 times
Oct 15 00:09:24 linnie last message repeated 3 times
Oct 15 00:11:26 linnie last message repeated 3 times
Oct 15 00:12:59 linnie kernel: [drm:radeon_freelist_get] *ERROR* returning
NULL!
Oct 15 07:12:19 linnie kernel: [drm:radeon_freelist_get] *ERROR* returning
NULL!
Oct 15 18:42:20 linnie syslogd 1.4.1: restart.
Oct 15 18:42:20 linnie syslog: syslogd startup succeeded
Oct 16 04:02:01 linnie syslogd 1.4.1: restart.
Oct 16 04:09:07 linnie kernel: [drm:radeon_freelist_get] *ERROR* returning
NULL!
Oct 16 17:44:52 linnie syslogd 1.4.1: restart.
Oct 16 17:44:52 linnie syslog: syslogd startup succeeded


I did not have them with ac10 and earlier, and the bad part is that after
the last two I found my PC locked -- once fully, no ping response on the
network -- once just with frozen keyboard/mouse but X displaying a frozen 
screen saver image.

Does anyone know what might have changed to cause this? 
It is a Tyan Tiger MP dual Athlon with Radeon LE 32MB DDR.
I'll be happy to provide more info if you tell me what is relevant.

Thanks. Willem Riede.
