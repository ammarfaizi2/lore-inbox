Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267484AbTAVNWS>; Wed, 22 Jan 2003 08:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267487AbTAVNWS>; Wed, 22 Jan 2003 08:22:18 -0500
Received: from relay2.uni-heidelberg.de ([129.206.210.211]:13995 "EHLO
	relay2.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S267484AbTAVNWR>; Wed, 22 Jan 2003 08:22:17 -0500
Date: Wed, 22 Jan 2003 14:31:17 +0100
From: Karl-Heinz Eischer <karl-heinz@eischer.net>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [TRIVAL PATCH 2.4.21-pre3] moved drivers/ide files and Configure.help
Message-ID: <20030122133117.GA11778@eischer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 in drivers/ide some files where moved into subdirectories, but in the
pointers to the files in Configure.help are to the old positions. Also
some of the files in the subdirs where containing the old path in the 
comments.

Also fixed is the renaming of CONFIG_BLK_DEV_PDC202XX to 
CONFIG_BLK_DEV_PDC203XX_OLD. 

The patches are found unter:
http://www.eischer.net/Linux/patch-drivers-ide.conf.help.gz
http://www.eischer.net/Linux/patch-drivers-ide.files.gz

Please cc comments to: karl-heinz@eischer.net.

KH

-- 
// In a world without walls and fences who needs Windows and Gates ? //
