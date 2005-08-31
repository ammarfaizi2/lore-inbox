Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbVHaPGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbVHaPGh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 11:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbVHaPGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 11:06:36 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:58800 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964828AbVHaPGg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 11:06:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=VPQF3dwZefnkJOCYqT0kCOQczbrJ13bSL4XZWeVdUEGHKaDFtjKlz3Xtfbv5AcIidb4oR+gKOQqFjG1WPmCQ0yz4/v4B0qG30nduaeqyWW+saM5oxFLwsS8AmvKY+9NGrqSR0g9KCq+h/ndUqtluynLaM1oF6dO8mf0UjnKCMPg=
Message-ID: <9a9e5ab90508310806114ab96b@mail.gmail.com>
Date: Wed, 31 Aug 2005 20:36:35 +0530
From: Nilesh Agrawal <nilesh.agrawal@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: tty problem
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have a peculiar problem with the kernel messages being printed during startup.
During startup the messages are printed only uptill the monitor
(screen) gets filled, the screen doesnt scroll down and no further
messages are printed. However the computer boots normally, and I get my
graphical desktop when X starts.
Moreover  moving to tty1 (CTRL-ALT-F1)  doesnt give me anything, but
mingetty program is running on tty1.
Booting in single user mode, the same problem persists. I cant see
anything after the screen gets filled.
Does anyone  know where is the problem??
Thanks in advance.

nilesh
