Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135710AbRDXSeJ>; Tue, 24 Apr 2001 14:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135709AbRDXSeA>; Tue, 24 Apr 2001 14:34:00 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:16648 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S135707AbRDXSdt>; Tue, 24 Apr 2001 14:33:49 -0400
From: mshiju@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: linux-kernel@vger.kernel.org
Message-ID: <CA256A38.0065E0A2.00@d73mta05.au.ibm.com>
Date: Tue, 24 Apr 2001 20:44:22 +0530
Subject: Problem with DHCP when using tokenring on 2.4.x
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,
           I have a problem with DHCP when using tokenring card on 2.4.x
kernel . When I am using IBM tokenring adapter( all) and trying to hook on
to the lan n/w using DHCP ,I get an error message "operation failed " from
the dhcp client . The dhcp server is getting the broadcast message when the
dhcp client  is run. I am using pump that comes with 6.2 redhat
distribution .  There is no problem when using static IP.  I could
experience this problem only  on 2.4.x . I am able to get a valid IP
address on  2.2.x kernel when using tokenring adapter. And also there is no
problem when using ethernet adapter on 2.4.x . . Has anyone experienced
this problem on 2.4.x . Can any one help me to resolve this problem.

Thanks & Regards
Shiju


