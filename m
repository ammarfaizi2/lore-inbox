Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318622AbSHAEhO>; Thu, 1 Aug 2002 00:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318623AbSHAEhO>; Thu, 1 Aug 2002 00:37:14 -0400
Received: from webmail10.rediffmail.com ([202.54.124.179]:24744 "HELO
	webmail10.rediffmail.com") by vger.kernel.org with SMTP
	id <S318622AbSHAEhO>; Thu, 1 Aug 2002 00:37:14 -0400
Date: 1 Aug 2002 04:40:26 -0000
Message-ID: <20020801044026.27710.qmail@webmail10.rediffmail.com>
MIME-Version: 1.0
From: "Enugala Venkata Ramana" <caps_linux@rediffmail.com>
Reply-To: "Enugala Venkata Ramana" <caps_linux@rediffmail.com>
To: linux-kernel@vger.kernel.org
Subject: installation of latest kernel on compaq notebook
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,
  This is what is existing configuration
    have compaq presario 1200 12XL506 model notebook
    installed Redhat Linux 7.1
    Everything is fine except the usb to ethernet (SmartNic2 
1500
) does not work although it is shown in the /proc/usb/devices

  This is what i tried
   downloaded latest kernel 2.5.29
   Installed kernel on linux laptop
   I am not very sure of what needs to be configured in the 
kernel
config
   When i tried "make xconfig" there is some error and x windows
does not start
   i did manual configuration and able to compile the new kernel
and boot on to it
   After boot on new kernel
   Now even the usb mouse is not recognized, Xwindows which is
working previously with kernel 2.4.x does not work.

Now what i want to know is
   What i need to select in kernel configurations so that it
supports my model with all basic features?
   Why there is always an error in prevois versions of my kernel
as well ('Error in line 5 in /etc/sysconfig/mouse') I comment 
line
fine everything is fine?

Please do reply in case anybody know any details on this.

thanks
Regards
Venku.
