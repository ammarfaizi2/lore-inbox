Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbVIZFva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbVIZFva (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 01:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbVIZFva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 01:51:30 -0400
Received: from ns1.lanforge.com ([66.165.47.210]:53641 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S932390AbVIZFva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 01:51:30 -0400
Message-ID: <43378C60.8090603@candelatech.com>
Date: Sun, 25 Sep 2005 22:51:28 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.10) Gecko/20050909 Fedora/1.7.10-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: FC4 + 2.6.13 + compaq nx5000 laptop:  Hang on boot.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I recently attempted to upgrade a compaq nx5000 laptop (Pentium-M)
to 2.6.13.  The system boots fine until it gets to the line:

Starting udev:  MAKEDEV: mkdir: File exists
The next line:  Initializing hardware...

never prints anything else.

The return key seems to work..nothing else I've tried does.

I also tried 2.6.13.2.  The kernel config is same as that of the latest
FC4 kernel (which is 2.6.12.something and works fine).

The kernel is built on an FC2 machine running 2.6.11, if that matters.

Any ideas?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

