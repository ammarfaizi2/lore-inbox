Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265472AbRFVRMF>; Fri, 22 Jun 2001 13:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265473AbRFVRLz>; Fri, 22 Jun 2001 13:11:55 -0400
Received: from fepout3.telus.net ([199.185.220.238]:42711 "EHLO
	priv-edtnes11-hme0.telusplanet.net") by vger.kernel.org with ESMTP
	id <S265472AbRFVRLk>; Fri, 22 Jun 2001 13:11:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Brad Pepers <brad@linuxcanada.com>
Organization: Linux Canada Inc.
To: linux-kernel@vger.kernel.org
Subject: Re: For comment: draft BIOS use document for the kernel
Date: Fri, 22 Jun 2001 11:11:31 -0600
X-Mailer: KMail [version 1.2]
In-Reply-To: <E15DTfd-0003gI-00@the-village.bc.nu>
In-Reply-To: <E15DTfd-0003gI-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <01062211113100.01758@dragon.linuxcan.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1.3	Type 'apm -s'
> 	The machine should standby
>
> 1.4	Wake it and type 'apm -S'
> 	The machine should suspend

According to the man pages, "apm -s" does a suspend and "apm -S" does a 
standby.

-- 
Brad Pepers
brad@linuxcanada.com
