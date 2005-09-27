Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbVI0EWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbVI0EWw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 00:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbVI0EWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 00:22:52 -0400
Received: from xproxy.gmail.com ([66.249.82.203]:12264 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932310AbVI0EWv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 00:22:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ilm6gvPLFJyapceL7uiP3xKR5DWFqFWeh9Lj/ihtG8F4ufPYUvVJeF71aVjdPf8cOQluuJiD9G6kigdSK4kik8RDGaNIZcEXWnPHeA0vF/T5h2ap8UkBXrWeS8PstHgrXUf3futFDsD19cV453iGpfa6RKcMbMnmD6k5Ez0OZ8o=
Message-ID: <309a667c0509262122260a7249@mail.gmail.com>
Date: Tue, 27 Sep 2005 09:52:51 +0530
From: devesh sharma <devesh28@gmail.com>
Reply-To: devesh sharma <devesh28@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.9 fail to boot with numa=fake=2 option
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,
I am trying 2.6.9 kernel to boot with boot time option as numa=fake=2
On intel xeon 64 bit 4 way SMP environment with 4GB Physical memory
but I am getting an error

Kenel penic : not syncing : kmem_cache_create() failed

I want to know whether numa=fake=N option is only available with AMD
opteron 64bit installation? Or It is supported with Intel also? If yes
then is there any limit of Physical memory after which this is
supported?

Devesh
