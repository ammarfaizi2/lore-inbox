Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVFMKBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVFMKBg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 06:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbVFMKBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 06:01:36 -0400
Received: from adsl-185-131-fixip.tiscali.ch ([212.254.185.131]:6067 "EHLO
	garfield.rptec.ch") by vger.kernel.org with ESMTP id S261379AbVFMKBc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 06:01:32 -0400
Message-ID: <42AD5978.2010503@rptec.ch>
Date: Mon, 13 Jun 2005 12:01:28 +0200
From: Jean-Eric Cuendet <jec@rptec.ch>
Organization: Riskpro Technologies SA
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: fedora-list@redhat.com, freshrpms-list@freshrpms.net,
       linux-kernel@vger.kernel.org
Subject: [new] kernel-desktop 2.6.11-1.27_FC3.desktop_2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I just released a new version of kernel-desktop. It's exactly the same 
as 2.6.11-1.27_FC3.desktop_1 but I forgot to enable the NTFS r/o driver, 
so this release just add NTFS r/o.

Kernel-desktop is based on the standard FC3 kernel, with the folowing
additions:
- NTFS read-only
- iNotify (Useful for Beagle, the search engine)
- Realtime LSM module (Useful for jack audio server)
- Con Kolivas patchset for interactivity

Available at http://apt.bea.ki.se/kernel-desktop

Happy upgrading!
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







