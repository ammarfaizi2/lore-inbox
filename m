Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267680AbSLTAIZ>; Thu, 19 Dec 2002 19:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267682AbSLTAIY>; Thu, 19 Dec 2002 19:08:24 -0500
Received: from hell.ascs.muni.cz ([147.251.60.186]:34688 "EHLO
	hell.ascs.muni.cz") by vger.kernel.org with ESMTP
	id <S267680AbSLTAIX>; Thu, 19 Dec 2002 19:08:23 -0500
Date: Fri, 20 Dec 2002 01:16:26 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: module loading on demand is not working? 2.5.52-bk4
Message-ID: <20021220001626.GB804@mail.muni.cz>
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

Am I something missing? I'm using nvidia kernel module. I have 
alias char-major-195 nvidia
in /etc/modules.conf and /etc/modprobe.conf 
but nvidia module is still not loaded on demand.
If I make modprobe nvidia then everything is ok.

-- 
Luká¹ Hejtmánek
