Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131742AbRDOXwm>; Sun, 15 Apr 2001 19:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132042AbRDOXwc>; Sun, 15 Apr 2001 19:52:32 -0400
Received: from juicer35.bigpond.com ([139.134.6.87]:37604 "EHLO
	mailin10.bigpond.com") by vger.kernel.org with ESMTP
	id <S131742AbRDOXwY>; Sun, 15 Apr 2001 19:52:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: David Findlay <david_j_findlay@yahoo.com.au>
Reply-To: david_j_findlay@yahoo.com.au
Organization: Davsoft
To: linux-kernel@vger.kernel.org
Subject: IP Acounting Idea for 2.5
Date: Tue, 17 Apr 2001 07:53:28 +1000
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01041707532801.00352@workshop>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using the kernel IP Accounting in Linux to record the amount of data 
transfered via my Linux internet gateway from individual IP addresses. This 
currently requires me to set up an accounting rule for each IP address that I 
want to record accounting info for. If I had 200 machines to individually log 
this would require me to set 200 rules.

In the 2.5 series of kernels, working towards 2.6, could you please make the 
IP Accounting so that I can set a single rule that will make it watch all IP 
traffic going from the local network, through the masquerading service to the 
internet, and log local IP Addresses using it? This would allow me to set 1 
rule, but have the information I want on a per IP address system.

One other person I have talked to would like to see this too, and he 
basically says we need a software version of the Cisco IP Accounting 
server/router.

Could you please add this to the next kernel? Please CC me your responses as 
I am not a member of the kernel mailing list. Thanks,

David
