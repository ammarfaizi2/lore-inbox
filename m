Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263925AbTEFQOH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 12:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263949AbTEFQOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 12:14:07 -0400
Received: from mail.convergence.de ([212.84.236.4]:5321 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263925AbTEFQN5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 12:13:57 -0400
Message-ID: <3EB7D970.8040205@convergence.de>
Date: Tue, 06 May 2003 17:49:04 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3) Gecko/20030408
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: torvalds@transmeta.com
Subject: [PATCH[[2.5][1-11] update the firmware of the av7110 dvb driver
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this patch updates the firmware of the av7110 driver.

Because of the fact that it's quite large, I've put it bzip2-compressed 
onto my private webpage at:

http://www.gdv.uni-hannover.de/~hunold1/01-av7110_firmware.diff.bz2

sezier patches # md5sum 01-av7110_firmware.diff.bz2
41d4a0db8549589b720352dcccce1b1a  01-av7110_firmware.diff.bz2

There is nothing to review in there, please apply.

Thanks
Michael Hunold.



