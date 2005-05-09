Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVEIPXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVEIPXl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 11:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVEIPXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 11:23:40 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:29733 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261424AbVEIPWi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 11:22:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BWwaWj/Jp/hO7/5P4eg2aWiI1dl88yHkxFJwwXcreChyJM1Bb1cumJPhOKxzAXEjf0iCNH6rUOKK14nNZCKKG1eYaHk0T2sjM2Bd8gFVtyPb9BxGkDS0P03cioE0UCknGjQ9Xp+5hIVYt9B6x8rCXYXsb9cwnDnx+RPeIyJiwQQ=
Message-ID: <3993a49805050908221f005d61@mail.gmail.com>
Date: Mon, 9 May 2005 17:22:38 +0200
From: Jouke Witteveen <j.witteveen@gmail.com>
Reply-To: Jouke Witteveen <j.witteveen@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Compile third-party module into the kernel
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm about to compile my new 2.4.27 (Debian Sarge) kernel. There is
only one hurdle left to take.
For my 3C905C-TX-M I wan't to use the latest vendor driver since I
heard the famous 3c59x is not optimal for that card. The driver of
choice is: http://support.3com.com/infodeli/tools/nic/linux/3c90x-102.tar.gz.
How do I compile this source (3c90x.c and 3c90x.h) directly into the
kernel (not as a module)? And how as a module inside a
my-kernel_modules.deb like ALSA
get's compiled?

Kind regards,
Jouke
