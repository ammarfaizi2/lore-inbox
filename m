Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261977AbSIYONz>; Wed, 25 Sep 2002 10:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261983AbSIYONz>; Wed, 25 Sep 2002 10:13:55 -0400
Received: from web12302.mail.yahoo.com ([216.136.173.100]:28981 "HELO
	web12302.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261977AbSIYONz>; Wed, 25 Sep 2002 10:13:55 -0400
Message-ID: <20020925141906.78323.qmail@web12302.mail.yahoo.com>
Date: Wed, 25 Sep 2002 07:19:06 -0700 (PDT)
From: Eric Miao <qjmiao@yahoo.com>
Subject: Some questions about Linux Framebuffer programming
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, everybody,

I need your help!

1. How can I switch to another virtual terminal by
normal user process?
VT_ACTIVATE ioctl can only be called by processes
having root rights.

2. When I switch away from and again back to the
virtual terminal where I do frame buffer drawing,
screen content is destroyed and replaced by original
console text?
How can I avoid this problem?

3. What is FBIOPUT_CON2FBMAP? What does it do?

4. How can I do flipping between primary frame and
secondary frame?





__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com
