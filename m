Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbUANGyy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 01:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264285AbUANGyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 01:54:54 -0500
Received: from brain.sedal.usyd.edu.au ([129.78.24.68]:62609 "EHLO
	brain.sedal.usyd.edu.au") by vger.kernel.org with ESMTP
	id S263895AbUANGyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 01:54:53 -0500
Message-ID: <400581C0.3070606@sedal.usyd.edu.au>
Date: Thu, 15 Jan 2004 04:52:00 +1100
From: sena <auntvini@sedal.usyd.edu.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robin Holt <holt@sgi.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Now  Load Averages and per user Load averages  are seperate.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

Thanks for your previous guidance.

 I have seperated load average (traditional) and load average per user code.

and  created a seperate file in /proc/loadavgus to collect the set I want.

 The new code has been integrated to the kernel and running well.

Previous problem  was a bug in the code.

loadavgus:
94.97 83.97 100 3.00 500 0.97 501 1.97 502 0.97 503 3.97 504


Thanks
Sena Seneviratne
Computer Engineering Lab
Sydney University

