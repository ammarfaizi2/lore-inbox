Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264084AbTICRQM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 13:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264114AbTICRQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 13:16:12 -0400
Received: from webmail25.rediffmail.com ([203.199.83.147]:44266 "HELO
	rediffmail.com") by vger.kernel.org with SMTP id S264084AbTICRQJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 13:16:09 -0400
Date: 3 Sep 2003 17:15:27 -0000
Message-ID: <20030903171527.30457.qmail@webmail25.rediffmail.com>
MIME-Version: 1.0
From: "Masoodur  Rahman" <rmasoodur@rediffmail.com>
Reply-To: "Masoodur  Rahman" <rmasoodur@rediffmail.com>
To: linux-kernel@vger.kernel.org
Subject: SMP image on a UP machine
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,

     Can I run a SMP kernel on a UP machine (x86 based ) ??

     I am working with 2.4.19 kernel compiled with CONFIG_SMP on a 
UniProcessor machine. The machine boots up with the SMP kernel 
configured in .

    The Problem comes when I try to create a kernel thread using 
the example at  http://www.scs.ch/~frey/linux/kernelthreads.html

   The entire machine hangs on loading the thread_mod.o ..

   What am I doing wrong ?? Is there any option that needs to be 
turned on to get this working ??

   Thanks for any help
   Regards


___________________________________________________
Medicine meets Marketing; Dr. Swati Weds Jayaram.
Rediff Matchmaker strikes another interesting match !!
Visit http://rediff.com/matchmaker?2

