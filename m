Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135397AbRDWPlX>; Mon, 23 Apr 2001 11:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135401AbRDWPlB>; Mon, 23 Apr 2001 11:41:01 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:59141 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135416AbRDWPi1>; Mon, 23 Apr 2001 11:38:27 -0400
Subject: Re: Kernel hang on multi-threaded X process crash
To: manuel@mclure.org (Manuel McLure)
Date: Mon, 23 Apr 2001 16:40:12 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010423082405.C979@ulthar.internal.mclure.org> from "Manuel McLure" at Apr 23, 2001 08:24:05 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14riRj-0008HH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Both mozilla and aviplay (which are both multithreaded) trigger this - I
> haven't tried with xmms. Simpler programs like xclock or cat don't trigger
> it.

Thanks. I'll revert the core dump stuff for 2.4.4-ac unless anyone cares to
fix the fix
