Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbSJFOzt>; Sun, 6 Oct 2002 10:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261647AbSJFOzt>; Sun, 6 Oct 2002 10:55:49 -0400
Received: from webmail7.rediffmail.com ([202.54.124.152]:46753 "HELO
	webmail7.rediffmail.com") by vger.kernel.org with SMTP
	id <S261645AbSJFOzt>; Sun, 6 Oct 2002 10:55:49 -0400
Date: 6 Oct 2002 15:06:16 -0000
Message-ID: <20021006150616.18817.qmail@webmail7.rediffmail.com>
MIME-Version: 1.0
From: "Purushothaman  Ravikumar" <purush_ravi@rediffmail.com>
Reply-To: "Purushothaman  Ravikumar" <purush_ravi@rediffmail.com>
To: linux-kernel@vger.kernel.org
Subject: FIle System In Embedded Devices
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

Can I know the file system that is used in the embedded devices 
based on linux? i.e whether it is RAM DISK based file system or 
JFFS.

Because, currently I am using RAM DISK file system of size 8 MB. 
When i try to increase the size beyond 11 MB the kernel crashes 
during boot. Again If i try to use 11 or 10 MB RAM DISK file 
system, the kernel boots successfully but i am not able to load 
some of the kernel modules.

But i need a file system of size atleast 11 MB.

Can any body throw some light on this?

with best regards,
Purush

(Note : my target board has 32 MB RAM.)
__________________________________________________________
Give your Company an email address like
ravi @ ravi-exports.com.  Sign up for Rediffmail Pro today!
Know more. http://www.rediffmailpro.com/signup/

