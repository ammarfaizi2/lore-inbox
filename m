Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbVAXLin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVAXLin (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 06:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbVAXLin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 06:38:43 -0500
Received: from web60603.mail.yahoo.com ([216.109.118.223]:27772 "HELO
	web60603.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261498AbVAXLim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 06:38:42 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=6Sgju3OUnmOIEvQbOe4OBc9VHNzzVDet4gjtXeA6DF7Wv70Q/SnSRFDYQ4YlNHM7LKmCq8jEKj9d2XqBrbjWL9Egbl8Kxxj4P1B7V+brMyxEOuRN/guWseFJ56zLRmLdjbYOJbKPG1L7nFXPNv6MBJ1+HLV1jUPG65L15XtTkcI=  ;
Message-ID: <20050124113841.50416.qmail@web60603.mail.yahoo.com>
Date: Mon, 24 Jan 2005 03:38:41 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: mkinitrd with module halts the kernel
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        I used mkinitrd along with the 'with' option
to create the initrd image along with my module. My
module intercepts read and write system calls. I am
using kernel 2.4.28. Now, when the kernel boots, it
hangs up and prompts for checking the disk. It never
proceeds to the next stage. How can I get rid of it?

Thanks,
selva


		
__________________________________ 
Do you Yahoo!? 
Meet the all-new My Yahoo! - Try it today! 
http://my.yahoo.com 
 

