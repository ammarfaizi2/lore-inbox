Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261486AbUKILu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbUKILu3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 06:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbUKILu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 06:50:29 -0500
Received: from mail-gateway-0-1.landonet.net ([196.25.111.196]:48522 "EHLO
	mail-gateway-0-1.landonet.net") by vger.kernel.org with ESMTP
	id S261486AbUKILuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 06:50:25 -0500
Message-ID: <4190AEFC.7060708@lbsd.net>
Date: Tue, 09 Nov 2004 11:50:20 +0000
From: Nigel Kukard <nkukard@lbsd.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041012
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ub vs. usb-storage
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Using kernel 2.6.9 bk7 and the UB driver for mass-storage I seem to see 
spikes on the load-avg of over 700. There is also times of extreme 
responsiveness deficiency.

Using the usb_storage driver seems to fix the problem. Is UB only meant 
  for low performance situations?


-Nigel
