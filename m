Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964979AbWFTDeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbWFTDeS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 23:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965452AbWFTDeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 23:34:18 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:38901 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965443AbWFTDeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 23:34:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=ien2FZKYSavuT1x6yJah/i11hB/nwIso6pjgeVvgUKMpOfHioKonarLfhPzOzpJi2dkphLL2u8GSHUo24GveVOLd2y6aSz5BOV3Dj7ki5g2JizsG5J1Y/3VwF5jvRJAnRtmeFEGODJObOpwI/RPW4QfNIaxFXPx6YocC9VpmTNw=
Message-ID: <44976CAA.8080000@gmail.com>
Date: Mon, 19 Jun 2006 22:34:02 -0500
From: hondaman <hondaman@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: trap divide error. X86_64, fc5, and 2.6.17
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I compiled 2.6.17 under fc5.  Halfway through the boot, the screen is 
filled with this message:
init[1] trap divide error rip:4296d7 rsp:7ffff792ed10 error:0
I didnt change any of the default settings in the kernel.  Just 
unzipped, make menuconfig, save, make and installed it. 
