Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267693AbSLSX6i>; Thu, 19 Dec 2002 18:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267695AbSLSX6i>; Thu, 19 Dec 2002 18:58:38 -0500
Received: from hell.ascs.muni.cz ([147.251.60.186]:25728 "EHLO
	hell.ascs.muni.cz") by vger.kernel.org with ESMTP
	id <S267693AbSLSX6g>; Thu, 19 Dec 2002 18:58:36 -0500
Date: Fri, 20 Dec 2002 01:06:38 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Colin Slater <hoho@tacomeat.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: 2.5.52-bk4
Message-ID: <20021220000637.GA804@mail.muni.cz>
References: <20021219.181921.41185800.hoho@tacomeat.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021219.181921.41185800.hoho@tacomeat.net>
User-Agent: Mutt/1.4i
X-Muni: zakazka, vydelek, firma, komerce, vyplata
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, Mossad, Iraq, Pentagon, WTC, president, assassination, A-bomb, kua, vic joudu uz neznam
X-policie-CR: Neserte mi nebo ukradnu, vyloupim, vybouchnu, znasilnim, zabiju, podpalim, umucim, podriznu, zapichnu a vubec vsechno
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2002 at 06:19:21PM -0500, Colin Slater wrote:
> ===== af_inet.c 1.36 vs edited =====
> --- 1.36/net/ipv4/af_inet.c	Sun Nov 24 20:15:49 2002
> +++ edited/af_inet.c	Thu Dec 19 18:09:38 2002

+ #include <linux/proc_fs.h>

solved that problem. Now it works ok for me.

...

-- 
Luká¹ Hejtmánek
