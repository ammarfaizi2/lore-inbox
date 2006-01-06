Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752313AbWAFAYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313AbWAFAYW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWAFAYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:24:22 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:30336 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752313AbWAFAYV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:24:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JkGm/vQQhwqP26syvDrXlh1DgjvkfQR4SWcQZxqX43jMjUS0di/vWQbDLjX4yF1Jkh62C6zSCHrJKhGLtyiuCUoH8VtymS2hdwN5AN07g3QfZVMA7iRGz5I7X2vvoQO9qkA3IuyExSDls+A62tQQedlzbqdgxXcs/Tn/BsRgESA=
Message-ID: <9a8748490601051624u36fb03d2l349c40a0165cbddb@mail.gmail.com>
Date: Fri, 6 Jan 2006 01:24:20 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>, LKML List <linux-kernel@vger.kernel.org>
Subject: 2.6.15-mm1: what's page_owner.c doing in Documentation/ ???
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just wondering what page_owner.c is doing in Documentation/ in 2.6.15-mm1 ;-)

$ ls -l linux-2.6.15-mm1/Documentation/page_owner.c
-rw-r--r--  1 juhl users 2587 2006-01-05 18:15
linux-2.6.15-mm1/Documentation/page_owner.c

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
