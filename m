Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316985AbSFFPXr>; Thu, 6 Jun 2002 11:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316993AbSFFPXq>; Thu, 6 Jun 2002 11:23:46 -0400
Received: from internal-bristol34.naxs.com ([216.98.66.34]:40097 "EHLO
	coredump.electro-mechanical.com") by vger.kernel.org with ESMTP
	id <S316985AbSFFPXp>; Thu, 6 Jun 2002 11:23:45 -0400
Date: Thu, 6 Jun 2002 11:19:18 -0400
From: William Thompson <wt@electro-mechanical.com>
To: linux-kernel@vger.kernel.org
Subject: PDC20267 + RAID can't find raid device
Message-ID: <20020606111918.F7291@coredump.electro-mechanical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After trying 2.4.19-pre10-ac2 I can finally use the PDC20267 controller,
however, it doesn't find any raid devices.

I have 2 quantum fireballlct10 05 on the controller (hde and hdg) and
created a stripe between these 2 disks in the controller's bios.

I can see both disks w/o problems.

I'd rather not use the linux software raid since you can't partition it.

IDE, PDC20267, FastTrak, and the raid driver are all compiled into the
kernel.

More info is available at request.
