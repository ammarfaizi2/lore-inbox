Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266407AbSKUIIU>; Thu, 21 Nov 2002 03:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266408AbSKUIIU>; Thu, 21 Nov 2002 03:08:20 -0500
Received: from webmail7.rediffmail.com ([202.54.124.152]:57573 "HELO
	webmail7.rediffmail.com") by vger.kernel.org with SMTP
	id <S266407AbSKUIIU>; Thu, 21 Nov 2002 03:08:20 -0500
Date: 21 Nov 2002 08:15:20 -0000
Message-ID: <20021121081520.7977.qmail@webmail7.rediffmail.com>
MIME-Version: 1.0
From: "Javed  Shakeel" <javedshakeel_list@rediffmail.com>
Reply-To: "Javed  Shakeel" <javedshakeel_list@rediffmail.com>
To: linux-kernel@vger.kernel.org
Subject: sys_shmat-ulong *raddr
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the system call

int sys_shmat (int shmid, char *shmaddr, int shmflg, ulong 
*raddr)

what is use of the argument "ulong *raddr"

__________________________________________________________
Give your Company an email address like
ravi @ ravi-exports.com.  Sign up for Rediffmail Pro today!
Know more. http://www.rediffmailpro.com/signup/

