Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266636AbUAONCo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 08:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266638AbUAONCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 08:02:44 -0500
Received: from dmz01.zas.gwz-berlin.de ([195.37.93.3]:63505 "HELO
	dmz01.zas.gwz-berlin.de") by vger.kernel.org with SMTP
	id S266636AbUAONCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 08:02:43 -0500
Message-ID: <40068F6E.9060901@zas.gwz-berlin.de>
Date: Thu, 15 Jan 2004 14:02:38 +0100
From: Axel Beier <axel@zas.gwz-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-DE; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: de-de, de-at, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: nfs version 2 access and kernel 2.6.x freeze
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
after upgrading to kernel 2.6.0 on client-side i cannot copy data from 
my (old) nfs server. The server is old (running SuSE 7.1 with a 2.4.19 
kernel) and supports only nfs version 2.
But with kernels 2.6.0 upto 2.6.1-mm2 after few seconds of copying a 
remote-file to the client the client hangs completely.
Kernel was compiled with gcc 3.3.1 and has preemptive enable.
No entry in the syslog....

Any idea except upgrading the server?
No problems with kernel 2.4.x....

Regards,
Axel
