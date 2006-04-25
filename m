Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWDYMAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWDYMAz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 08:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWDYMAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 08:00:55 -0400
Received: from pproxy.gmail.com ([64.233.166.176]:40134 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932202AbWDYMAz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 08:00:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ReINOBcECLjXK+2DKCJ5I6qvnnf+9MlPSQXI0p05h0z2oj7gw93ZxeW0vNj3wipvqvxoyBbSSYYB+YKHEyCG27PyqHCC6rBZoH9IMAPBfLe6rSTtQv0tvjKnYIay+UKvK+58ZZPEjx8MtHXcyk7f9Inv3SX0I0Yb/tTPEUALL7o=
Message-ID: <8bf247760604250500r435c692es5e01e5617b515e50@mail.gmail.com>
Date: Tue, 25 Apr 2006 05:00:54 -0700
From: Ram <vshrirama@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: problems with printk's
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  i am studing a driver's code.

  i have added a line printk (KERN_DEBUG __FUNCTION)  which is supposed to
  print the name of the function.

  I want to trace the program - what is happening.


  When i see the output of the driver using dmesg

  Only some of the prints are visible (some of them are not printed
even though they
   must get printed. i dont know why this is happening.

  Is there any limit on printk (like number of messages....)


  How do i disable (ie printk should print irrespective of any limit
or anything).


  Regard,,
   sriram
