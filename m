Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267438AbTAGRij>; Tue, 7 Jan 2003 12:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267440AbTAGRij>; Tue, 7 Jan 2003 12:38:39 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:23948 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S267438AbTAGRij>;
	Tue, 7 Jan 2003 12:38:39 -0500
Date: Tue, 7 Jan 2003 18:47:17 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200301071747.SAA23926@harpo.it.uu.se>
To: david.fort@intranode.com, linux-kernel@vger.kernel.org
Subject: Re: Ooops in 2.4.21-pre2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Jan 2003 09:23:15 +0100, FORT David wrote:
>I caught that oops when trying 2.4.21-pre2, the oops clearly occurs when
>the ide-tape module is unloaded. When ide-tape is compiled in the kernel
>everything is fine. Despite that oops the corrections on ide-tape are 
>just fine,

I reported this to LKML several weeks ago. 2.4.21-pre3 fixed the bug.

/Mikael
