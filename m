Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbULMRCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbULMRCU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 12:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbULMRCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 12:02:20 -0500
Received: from 4s.enrico.unife.it ([192.167.219.82]:23223 "EHLO
	quatresse.ferrara.linux.it") by vger.kernel.org with ESMTP
	id S261274AbULMRCR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 12:02:17 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
Subject: Re: 2.6.10-rc3-mm1
Date: Mon, 13 Dec 2004 18:02:11 +0100
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20041213020319.661b1ad9.akpm@osdl.org> <Pine.LNX.4.61.0412131603370.14874@student.dei.uc.pt>
In-Reply-To: <Pine.LNX.4.61.0412131603370.14874@student.dei.uc.pt>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200412131802.12674.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 17:15, lunedì 13 dicembre 2004, Marcos D. Marado Torres ha scritto:

> OTOH, while I had no problems with the previous mm's or with 2.6.10-rc3,
> with -rc3-mm1 kdm has an weird function: with kdm/unstable uptodate
> 4:3.3.1-3 from Debian it just restarts X when it's going to show the
> login/password form, restarting over and over.
>

Confirmed here: I'm looking at logs to find out what's going on so I've no 
useful debug infos yet (sorry), but the I've seen the same behaviour on my 
box. (not a debian issue, seen also on mdk cooker (kde 3.3.2/xorg 6.8.1) )
More infos later.


-- 
Fabio "Cova" Coatti    http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
