Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161040AbWARXK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161040AbWARXK6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 18:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161041AbWARXK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 18:10:58 -0500
Received: from ns2.lanforge.com ([66.165.47.211]:49846 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S1161040AbWARXK6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 18:10:58 -0500
Message-ID: <43CECB00.40405@candelatech.com>
Date: Wed, 18 Jan 2006 15:10:56 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Can you specify a local IP or Interface to be used on a per NFS mount
 basis?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Is there any way to specify what local IP address an NFS
client uses to mount an NFS server?

For instance, if I have eth0 with IP 192.168.1.6 and eth1
with IP 192.168.1.7, how can I make sure that a particular
mount point is accessed via 192.168.1.7?

If not NFS..can it be done with SMB?

The current man pages seem to indicate it cannot be done, but
maybe someone knows some kludge to get it working?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

