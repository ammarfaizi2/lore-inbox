Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266233AbSLSVjV>; Thu, 19 Dec 2002 16:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266246AbSLSVjV>; Thu, 19 Dec 2002 16:39:21 -0500
Received: from hell.ascs.muni.cz ([147.251.60.186]:22912 "EHLO
	hell.ascs.muni.cz") by vger.kernel.org with ESMTP
	id <S266233AbSLSVjU>; Thu, 19 Dec 2002 16:39:20 -0500
Date: Thu, 19 Dec 2002 22:47:21 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: BUG: 2.5.52-bk4
Message-ID: <20021219214721.GA900@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
X-Muni: zakazka, vydelek, firma, komerce, vyplata
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, Mossad, Iraq, Pentagon, WTC, president, assassination, A-bomb, kua, vic joudu uz neznam
X-policie-CR: Neserte mi nebo ukradnu, vyloupim, vybouchnu, znasilnim, zabiju, podpalim, umucim, podriznu, zapichnu a vubec vsechno
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

If I try to open (to view) /proc/net/tcp in midnight commander then 
the midnight commander freezes in kernel (cannot be killed) with 99% CPU usage.

I do not see any disk_io line in /proc/stat although I have /dev/hda as primary
disk. Maybe because I'm using boot_off first and ide=reverse. So real /dev/hda
does not exist and /dev/hde is as /dev/hda.

-- 
Luká¹ Hejtmánek
