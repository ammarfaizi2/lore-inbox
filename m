Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbTDVRkp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 13:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263311AbTDVRkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 13:40:45 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:8109 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263309AbTDVRko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 13:40:44 -0400
Date: Tue, 22 Apr 2003 19:52:50 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-kernel@vger.kernel.org
Subject: 2.5.68-je1
Message-ID: <20030422175250.GA12947@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Included patches:
VERSION		- The obvious
checkstack	- Static stack checker
stack_overflow	- Show stack overflow at 3k instead of 7k
msdos		- Compile fs/partition/msdos.o for fewer targets
8023		- Put the 802.3 code behind CONFIG_IPX
wan-stack	- stack reduction patch
cpqarray-stack	- ""
gdth		- ""
intermezzostack	- ""
amd-stack	- ""

Both the full and the individual patches can be found here:
http://wh.fh-wedel.de/~joern/software/kernel/je/25/

Same applies to the 2.4 series:
http://wh.fh-wedel.de/~joern/software/kernel/je/24/


Jörn

-- 
They laughed at Galileo.  They laughed at Copernicus.  They laughed at
Columbus. But remember, they also laughed at Bozo the Clown.
-- unknown
