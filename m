Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272590AbRIPRnZ>; Sun, 16 Sep 2001 13:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272632AbRIPRnR>; Sun, 16 Sep 2001 13:43:17 -0400
Received: from a10d14hel.dial.kolumbus.fi ([212.54.29.10]:45229 "EHLO
	porkkala.jlaako.pp.fi") by vger.kernel.org with ESMTP
	id <S272590AbRIPRnE>; Sun, 16 Sep 2001 13:43:04 -0400
Message-ID: <3BA4E4B1.BD4621DD@kolumbus.fi>
Date: Sun, 16 Sep 2001 20:43:13 +0300
From: Jussi Laako <jussi.laako@kolumbus.fi>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.9-ac10
In-Reply-To: <20010908005500.A11127@lightning.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> **      Radeon dri report needs checking still

Radeon VE with agpgart (AMD 761) works as before; it doesn't (deadlock).
XFree86-CVS comes up nicely with AGP disabled (and thus DRI/DRM is disabled
also).

 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers
