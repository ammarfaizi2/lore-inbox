Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272045AbRH2TEo>; Wed, 29 Aug 2001 15:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272049AbRH2TEY>; Wed, 29 Aug 2001 15:04:24 -0400
Received: from imo-d01.mx.aol.com ([205.188.157.33]:36016 "EHLO
	imo-d01.mx.aol.com") by vger.kernel.org with ESMTP
	id <S272045AbRH2TEW>; Wed, 29 Aug 2001 15:04:22 -0400
From: Floydsmith@aol.com
Message-ID: <28.19e90598.28be96a1@aol.com>
Date: Wed, 29 Aug 2001 15:04:01 EDT
Subject: Re: 2.4.9 ide-floppy broken - 2.4.8 works ok
To: Floydsmith@aol.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: AOL 4.0 for Windows 95 sub 14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More info on this problem: I replaced both ./drivers/ide/ide-floppy.c and 
ide.c from ones in 2.4.8 and recompiled and this particular problem goes away 
- both must be replaced though.

Floyd,
