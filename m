Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282999AbRLMEjU>; Wed, 12 Dec 2001 23:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283320AbRLMEjK>; Wed, 12 Dec 2001 23:39:10 -0500
Received: from [209.1.214.217] ([209.1.214.217]:10001 "EHLO
	iso2.vistocorporation.com") by vger.kernel.org with ESMTP
	id <S282999AbRLMEjA> convert rfc822-to-8bit; Wed, 12 Dec 2001 23:39:00 -0500
Message-ID: <3C07FBEF000B2E21@iso2.vistocorporation.com> (added by
	    administrator@vistocorporation.com)
Reply-To: linuxlist@visto.com
From: "rohit prasad" <linuxlist@visto.com>
Subject: Kernel size
Date: Wed, 12 Dec 2001 20:38:00 -0800
X-Mailer: Visto
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
X-Mailer: Visto Server
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I re-compiled linux from the /usr/src/linux-2.4.x directory and included only the NTFS support read only to the newly compiled kernel the remaining defaults were untouched and created and installed as modules using make modules and make modules_install. 

But whatever bzImage that I got and moved to /boot and updated the lilo.conf for this new image and ran lilo I got a warning "Fatal kernel too big " 

I am unable to debug this problem . 
After compilation and final image is generated the make returns following comments , 
What do they mean, 
Root Device (3, 5) 
system 1137KB 
setup is 4648kB 
after bzImage is created. 

My system has 20gb of partition space. 
Do let me know pls, 
Thanks, 
Rohit 

___________________________________________________________________________
Visit http://www.visto.com.
Find out  how companies are linking mobile users to the 
enterprise with Visto.

