Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285709AbRLTAiI>; Wed, 19 Dec 2001 19:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285707AbRLTAh7>; Wed, 19 Dec 2001 19:37:59 -0500
Received: from cm61-15-169-117.hkcable.com.hk ([61.15.169.117]:15488 "EHLO
	cm61-15-169-117.hkcable.com.hk") by vger.kernel.org with ESMTP
	id <S285704AbRLTAhn>; Wed, 19 Dec 2001 19:37:43 -0500
Message-ID: <3C2131FC.6040209@rcn.com.hk>
Date: Thu, 20 Dec 2001 08:34:04 +0800
From: David Chow <davidchow@rcn.com.hk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: nfsroot dead slow with redhat 7.2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

When I use 2.4.7-10 i686 kernel from stock Redhat 7.2 as the NFS server. 
My NFS client use the 2.4.13 kernel, when I mount the nfsroot to the 
server, I found it is dead slow on the client. This only happens in i686 
kernel on the server, if we use a K6-2 uses an i386 server its fine. 
What's going on? By the way, how to configure the client to default use 
a NFSv3 mount? Thanks.

regards,

David

