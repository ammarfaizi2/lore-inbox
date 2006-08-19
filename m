Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751743AbWHSMkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbWHSMkw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 08:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751748AbWHSMkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 08:40:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:17010 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751735AbWHSMkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 08:40:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cO03lroY3jRX/nHkaGZKTnaTJkMsV1YAhD9ruiw1rCd021Kle1/G3Qa5s92IblmnsVSwH+mfbmBfUSAXDwIWEXcZoknoJu3OEuoiDVcanWJ6BfIFGAQYbckekTAPuZphOw3gClNBz6FBl+F3+8/+XZVF5zSqZW0zFE2ggzTsdHY=
Message-ID: <ec9e7ff10608190540o5ac666bau1451d43e69e66417@mail.gmail.com>
Date: Sat, 19 Aug 2006 20:40:50 +0800
From: "Kun Niu" <haoniukun@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: How can I enable NET_WIRELESS?
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I'm sorry for the silly questoin.
My kernel version is 2.6.17
But I've just installed the 802.11 stack on my Debian 3.1.
But I got that the module can't find some external module:
WARNING: /lib/modules/2.6.17-5/kernel/net/ieee80211/softmac/ieee80211softmac.ko
needs unknown symbol wireless_send_event
WARNING: /lib/modules/2.6.17-5/kernel/net/ieee80211/ieee80211.ko needs
unknown symbol wireless_spy_update
And I think that I'll have to install the NET_WIRELESS module.
But I can't find it.
When I look for wireless in menuconfig of the kernel, I found that
NET_WIRELESS=n.

Would anyone be kind enough telling how to enable NET_WIRELESS?

Thanks in advance.
