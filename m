Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbTIROaH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 10:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbTIROaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 10:30:07 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:12281 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261427AbTIROaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 10:30:04 -0400
Importance: Normal
Sensitivity: 
Subject: Re: cpu speed
To: koala.gnu@tiscali.it
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OF70311BA5.5F9F0160-ONC1256DA5.004F6FD6-C1256DA5.004F764C@italy.ibm.com>
From: "Mario Noioso" <MNOIOSO@it.ibm.com>
Date: Thu, 18 Sep 2003 16:29:55 +0200
X-MIMETrack: Serialize by Router on D14ML009/14/M/IBM(Release 5.0.9a |January 7, 2002) at
 18/09/2003 16:29:58
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Koala GNU wrote:
      >>Hi all,
      >>I have a T21 thinkpad Pentium III 800 MHz.
      >>I have redhat 8.0 with linux 2.4.18 installed on my machine.
      >>Executing cat /proc/cpuinfo I noticed that cpu speed is 200 MHz.
      >>Looking at BIOS the speed is correct.

Hi,
This steps are for you:
1. Go in bios setup
2. Select config/power
3. set to customized "power ac mode"
4. set to customized "power mode for battery"
5. set to fixed max processor speed

-----------------------------------
enjoy
http://neuromante.homelinux.com
-----------------------------------

