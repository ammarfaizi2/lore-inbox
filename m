Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281461AbRKZEHO>; Sun, 25 Nov 2001 23:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281464AbRKZEHE>; Sun, 25 Nov 2001 23:07:04 -0500
Received: from [209.1.214.217] ([209.1.214.217]:34566 "EHLO
	iso2.vistocorporation.com") by vger.kernel.org with ESMTP
	id <S281461AbRKZEGv> convert rfc822-to-8bit; Sun, 25 Nov 2001 23:06:51 -0500
Message-ID: <3BE1CB8E0013F650@iso2.vistocorporation.com> (added by
	    administrator@vistocorporation.com)
Reply-To: linuxlist@visto.com
From: "rohit prasad" <linuxlist@visto.com>
Subject: no inetd.conf file
Date: Sun, 25 Nov 2001 20:06:58 -0800
X-Mailer: Visto
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
X-Mailer: Visto Server
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

 I have installed 2.4.7 version of the kernel in my machine.
I am facing a problem with telnet where all connections are refused.

 When I grep for telnetd there is no telnetd  running.
If I try to start it the error reported is ,

"telnetd:getpeername:socket operation on non-socket"

I checked for the inetd.conf file it is not present in the /etc directory.

 I want to know does this xinetd.conf file helps or,
what else could I do to start telnetd.

I have done a "Everything" (All packages) installation of RH7.2 but no inetd.conf

Thanks ,
Rohit

 


___________________________________________________________________________
Visit http://www.visto.com.
Find out  how companies are linking mobile users to the 
enterprise with Visto.

