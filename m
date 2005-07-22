Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVGVS2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVGVS2x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 14:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVGVS2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 14:28:53 -0400
Received: from web60715.mail.yahoo.com ([209.73.178.218]:13236 "HELO
	web60715.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261369AbVGVS2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 14:28:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.br;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=6R+cP89vmeb95x/LoRVSPKQUjgjqJTlTx8W11sjMPOZzPYtkfjr9omfHjDpr5qSYDQ4oQ+F1/sLsJ1NkVkVRQRMGXd5dM/tgJIls7xxHTU8e1MdqCibaCihjjKlswjfL0stgL27nmoXUW5l5Qoa8um5DlruvNAeLcBSUqD1sbaM=  ;
Message-ID: <20050722182848.8028.qmail@web60715.mail.yahoo.com>
Date: Fri, 22 Jul 2005 15:28:48 -0300 (ART)
From: "Francisco Figueiredo Jr." <fxjrlists@yahoo.com.br>
Subject: "seeing minute plus hangs during boot" - 2.6.12 and 2.6.13
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi all,

Sorry for sending this issue to your attention again, but I got no answers and
I thought it could be because of my bad subject message.

I'm having little hangs while booting with kernels 2.6.12 and 2.6.13-rc1, rc2
and rc3.

Hangs appears just before mounting filesystems message and before configuring
system to use udev.
 
I'm using Gentoo with vanilla-sources. I already asked on gentoo lists and
nobody saw this behaviour. I tried google with no luck too. So my last
resource which could give me some light is here.

Do you know of something about this? Have you seen this problem?
Where could I look for more information about that in my system? I saw logs
but they don't say anything. Also, besides this hangs on boot, system seems to
work perfectly, but I'd like to remove this hangs from boot.

Thanks in advance.

--
Regards,

Francisco Figueiredo Jr.


__________________________________________________
Converse com seus amigos em tempo real com o Yahoo! Messenger 
http://br.download.yahoo.com/messenger/ 
