Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262240AbVCWNUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbVCWNUk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 08:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262287AbVCWNUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 08:20:40 -0500
Received: from web52202.mail.yahoo.com ([206.190.39.84]:63826 "HELO
	web52202.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262240AbVCWNUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 08:20:36 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=v3ADqWDwl/oe76SdpS5UNzhDG5L8KLeMRG1MjLXp+XajM0pjBQ5MxZrg95xvF7XOy9aOsTHFzDWQLAy0FWLvJvqjfLaonOXfSMB5JQ8Kp1wMNCfcJdCLh+UZJbo0cDG7N4b4RYad8qRHvWvDb5Sywi8mhh1/npWc5jFBhMwPVD8=  ;
Message-ID: <20050323132036.99757.qmail@web52202.mail.yahoo.com>
Date: Wed, 23 Mar 2005 05:20:36 -0800 (PST)
From: linux lover <linux_lover2004@yahoo.com>
Subject: Accessing data structure from kernel space
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
        I have one linked list data structure added to
a file in kernel source code which has some kernel
info. I want to acess that linked list structure from
user space. Is that possible?? 
        Also how to add own system call usable at user
level from kernel module??
regards,
linux_lover.


		
__________________________________ 
Do you Yahoo!? 
Make Yahoo! your home page 
http://www.yahoo.com/r/hs
