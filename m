Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262325AbVEYM3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbVEYM3r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 08:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbVEYM1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 08:27:55 -0400
Received: from adsl-185-131-fixip.tiscali.ch ([212.254.185.131]:18642 "EHLO
	garfield.rptec.ch") by vger.kernel.org with ESMTP id S262320AbVEYM1k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 08:27:40 -0400
Message-ID: <42946F37.2060203@rptec.ch>
Date: Wed, 25 May 2005 14:27:35 +0200
From: Jean-Eric Cuendet <jec@rptec.ch>
Organization: Riskpro Technologies SA
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: fedora-list@redhat.com, freshrpms-list@freshrpms.net,
       linux-kernel@vger.kernel.org
Cc: Con Kolivas <kernel@kolivas.org>
Subject: [new] kernel-desktop 2.6.11-1.27_FC3.desktop_1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I just released a new version of kernel-desktop. New features are:
- Based on FC3 2.6.11-1.27_FC3 kernel
- Include 2.6.11.10 patch
- Include Con Kolivas CK8 patchset (with Staircase11)
- The rest is the same as in 1.14_FC3.desktop_5

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







