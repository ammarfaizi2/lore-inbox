Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265773AbSLSQ15>; Thu, 19 Dec 2002 11:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265791AbSLSQ15>; Thu, 19 Dec 2002 11:27:57 -0500
Received: from [81.2.122.30] ([81.2.122.30]:6663 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S265773AbSLSQ14>;
	Thu, 19 Dec 2002 11:27:56 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212191647.gBJGlT8s001992@darkstar.example.net>
Subject: 2.5 sbpcd config error
To: linux-kernel@vger.kernel.org
Date: Thu, 19 Dec 2002 16:47:29 +0000 (GMT)
Cc: emoenke@gwdg.de
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just noticed, the help text for this driver says:

> This driver can support up to four CD-ROM controller cards, and each
> card can support up to four CD-ROM drives; if you say Y here, you
> will be asked how many controller cards you have.

but it doesn't seem to prompt for the second and subsequent interfaces
like 2.4 does.

I know, there are probably not many people using five or more of the
corresponding CD-ROM drives on a 2.5 machine, (I don't even own one of
the drives), but I thought I'd point it out.

John.
