Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267365AbUIJMMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267365AbUIJMMk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 08:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267378AbUIJMMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 08:12:40 -0400
Received: from adsl-185-131-fixip.tiscali.ch ([212.254.185.131]:60082 "EHLO
	garfield.rptec.ch") by vger.kernel.org with ESMTP id S267365AbUIJMKD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 08:10:03 -0400
Message-ID: <41419990.6010801@rptec.ch>
Date: Fri, 10 Sep 2004 14:09:52 +0200
From: Jean-Eric Cuendet <jec@rptec.ch>
Organization: Riskpro Technologies SA
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: fedora-list@redhat.com, freshrpms-list@freshrpms.net,
       linux-kernel@vger.kernel.org
Subject: [new] kernel-desktop 2.6.8-1.521.desktop.6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I just released a new version of kernel-desktop
Available at http://apt.bea.ki.se/kernel-desktop

Features are:
- Base FC2 kernel 2.6.8-1.521
- Removed some FC2 patches which caused slowdown when mixed with CK patch
- Added 2.6.8-CK6 patchset (latency fixes + staircase scheduler)
- Added the FUSE module (http://avf.sf.net)
- Added config for Supermount
- Added config for NTFS ro
- Added config for Reiser4

Happy kernel playing!
-jec

-- 
Jean-Eric Cuendet
Riskpro Technologies SA
Av du 14 avril 1b, 1020 Renens Switzerland
Principal: +41 21 637 0110  Fax: +41 21 637 01 11
Direct: +41 21 637 0123
E-mail: jean-eric.cuendet at rptec.ch
http://www.rptec.ch
--------------------------------------------------------



