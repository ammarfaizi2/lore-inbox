Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbVEJU1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbVEJU1j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 16:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbVEJU1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 16:27:39 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:43941 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261762AbVEJU1i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 16:27:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=MhMb4RDyim+1P8cO4SYbUep5MIZk1FqIErMuRFl1X4anCkP7GZNEBzT7XqoVoJtxTQ9b2IUYLMeI9Jmtt+Fl0LpVDNXchkagYD8wWyUy9yX98qmIqCDQnizFCkBsza0MsPVxhf4tKbY6/Ezg92BApkT7dl/2F34gF87XfboMvsY=
Message-ID: <7f800d9f050510132762f0ee7@mail.gmail.com>
Date: Tue, 10 May 2005 13:27:38 -0700
From: Andre Eisenbach <int2str@gmail.com>
Reply-To: Andre Eisenbach <int2str@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: High res timer?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

We're currently using pth_usleep() as a timer for a userspace audio
application. However, it doesn't seem very accurate and reliable. Is
there a better (more accurate) timer that we can call form a userspace
application?

Thanks,
    Andre
