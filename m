Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273509AbRIQHVi>; Mon, 17 Sep 2001 03:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273507AbRIQHV2>; Mon, 17 Sep 2001 03:21:28 -0400
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:34309 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S273508AbRIQHVK>; Mon, 17 Sep 2001 03:21:10 -0400
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Mon, 17 Sep 2001 09:12:53 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: 2.4.9: multiply mounting filesystem
Message-ID: <3BA5BE90.29409.43AC7B@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
X-Content-Conformance: HerringScan-0.9/Sophos-3.47+2.4+2.03.072+02 July 2001+64955@20010917.070651Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

yesterday I mounted a filesystem /dev/sda9 (resierfs) twice (first time 
as /, second time as /mnt) by mistake. Neither kernel nor mount program 
complained. I'm very much afraid this could corrupt the filesystem. Or 
is Linux really smart enough to handle the case?  

Regards,
Ulrich
P.S. I'm not subscribed here.

