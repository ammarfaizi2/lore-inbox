Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132810AbRDQSaG>; Tue, 17 Apr 2001 14:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132809AbRDQS3r>; Tue, 17 Apr 2001 14:29:47 -0400
Received: from hnlmail3.hawaii.rr.com ([24.25.227.37]:6407 "EHLO hawaii.rr.com")
	by vger.kernel.org with ESMTP id <S132810AbRDQS3k>;
	Tue, 17 Apr 2001 14:29:40 -0400
From: Sam.Bingner@hickam.af.mil
Reply-to: Sam.Bingner@hickam.af.mil
To: cfriesen@nortelnetworks.com, sampsa@netsonic.fi
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Date: Tue, 17 Apr 2001 08:25:21 -1000
Subject: RE: ARP responses broken!
X-Mailer: DMailWeb Web to Mail Gateway 2.3t, http://netwinsite.com/top_mail.htm
Message-id: <3adc8a91.db.0@hawaii.rr.com>
X-User-Info: 131.38.214.4
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Correction, that was on kernel v2.2.19

Sam

****** Forwarded Message Follows *******
>To: "'Christopher Friesen'" <cfriesen@nortelnetworks.com>,   Sampsa Ranta	

<sampsa@netsonic.fi>
>From: "Bingner Sam J. Contractor RSIS" <Sam.Bingner@hickam.af.mil>
>Date: Tue, 17 Apr 2001 18:07:41 -0000
>
>I tested this with kernel version 2.2.18 and arp_filter appeared to be
>broken... I enabled it for /proc/sys/net/ipv4/conf/all/arp_filter,
>/proc/sys/net/ipv4/conf/eth0/arp_filter and
>/proc/sys/net/ipv4/conf/eth1/arp_filter and it did not change the arp
>behavior at all.  I enabled hidden and it worked, is there a know problem
>with this functionality?
>
>	Sam Bingner
>	PACAF CSS/SCHE
>	Contractor RSIS
>	DSN	315 449-7889
>	COMM	808 449-7889
>
