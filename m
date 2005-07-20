Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbVGTP3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVGTP3G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 11:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbVGTP3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 11:29:05 -0400
Received: from adsl-185-131-fixip.tiscali.ch ([212.254.185.131]:4785 "EHLO
	garfield.rptec.ch") by vger.kernel.org with ESMTP id S261364AbVGTP3E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 11:29:04 -0400
Message-ID: <42DE6DBD.2030902@rptec.ch>
Date: Wed, 20 Jul 2005 17:29:01 +0200
From: Jean-Eric Cuendet <jec@rptec.ch>
Organization: Riskpro Technologies SA
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: fedora-list@redhat.com, freshrpms-list@freshrpms.net,
       linux-kernel@vger.kernel.org
Cc: Con Kolivas <kernel@kolivas.org>, David Goetschmann <dgo@rptec.ch>,
       jmsunseri@gmail.com, bcs@metacon.ca, ling@caltech.edu,
       posti@tomihalonen.com, killers_soul@hotmail.com, bhb@iceburg.net,
       mike.savage@gmail.com
Subject: [new] kernel-desktop 2.6.12-1.1398_FC4.desktop_1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I just released a new version of kernel-desktop. New features are:
- Based on FC4 2.6.12-1.1398_FC4 kernel
- Include 2.6.12.3pre patch
- Include Con Kolivas CK8 patchset (with Staircase11)

Kernel-desktop is based on the standard FC3 kernel, with the folowing
additions:
- NTFS read-only
- iNotify (Useful for Beagle, the search engine)
- Realtime LSM module (Useful for jack audio server)
- Con Kolivas patchset for interactivity

Available at http://apt.bea.ki.se/kernel-desktop

Happy desktoping!
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







