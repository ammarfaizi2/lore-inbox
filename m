Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263949AbRFMTOs>; Wed, 13 Jun 2001 15:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264124AbRFMTOi>; Wed, 13 Jun 2001 15:14:38 -0400
Received: from c009-h008.c009.snv.cp.net ([209.228.34.121]:13285 "HELO
	c009.snv.cp.net") by vger.kernel.org with SMTP id <S263949AbRFMTO0>;
	Wed, 13 Jun 2001 15:14:26 -0400
Date: 13 Jun 2001 12:14:18 -0700
Message-ID: <20010613191418.17176.cpmta@c009.snv.cp.net>
X-Sent: 13 Jun 2001 19:14:18 GMT
Content-Type: text/plain
Content-Disposition: inline
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
From: dipi_k@123india.com
X-Mailer: Web Mail 3.9.3.1
X-Sent-From: dipi_k@123india.com
Subject: net_device list in kernel
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
  
 I have one doubt.

  There is a list of the devices(net_device{} structures) maintained in kernel which has all the interfaces initialised by that time. This list is refrenced by dev_base variable.

 I need following info

1) does kernel maintain a global variable which keeps the count of net_device{} in above list?

2) Is this list modified(net_device{} added or deleted ) once it's initialised at boot time?

PLEASE reply to my PERSONAL account. I haven't subscribed to this mailing list.

thanks & regards,
Deepika


______________________________________________________
123India.com - India's Premier Portal 
Get your Free Email Account at http://www.123india.com
		     
------- End of forwarded message -------


______________________________________________________
123India.com - India's Premier Portal 
Get your Free Email Account at http://www.123india.com


