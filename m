Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272316AbTHIKdG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 06:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272319AbTHIKdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 06:33:06 -0400
Received: from fep02-mail.bloor.is.net.cable.rogers.com ([66.185.86.72]:59682
	"EHLO fep02-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S272316AbTHIKdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 06:33:05 -0400
Message-ID: <3F34D0EA.8040006@rogers.com>
Date: Sat, 09 Aug 2003 06:46:02 -0400
From: gaxt <gaxt@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030727 Thunderbird/0.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: preining@logic.at, linux-kernel@vger.kernel.org
Subject: 2.6.0-test3 cannot mount root fs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep02-mail.bloor.is.net.cable.rogers.com from [24.102.238.105] using ID <dw2price@rogers.com> at Sat, 9 Aug 2003 06:32:11 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > I am trying 2.6.0-test3 but cannot get the kernel to mount /dev/hdb1
 > which is the root fs.

Try changing in your bootloader root=/dev/hdb1 to root=341

