Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbVIZIze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbVIZIze (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 04:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbVIZIze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 04:55:34 -0400
Received: from xproxy.gmail.com ([66.249.82.206]:47314 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932434AbVIZIzd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 04:55:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=UQnTRjZIfMYnsA+bWg9zeMVJb/KZO7E62OrA2wAFAtMkzNkoBomuPf9VMJk76W6+OsGzsmDtHPoJdjsvFFbUJGdeK82PTdoc4KDO/Hfj7nXib/lxI9nyJVmCt4aCp9N6kxxVL5rHSJGt4jeskc+3bJAfsRxfCWibybirobz4rxs=
Message-ID: <309a667c05092601553a14a22@mail.gmail.com>
Date: Mon, 26 Sep 2005 14:25:28 +0530
From: devesh sharma <devesh28@gmail.com>
Reply-To: devesh sharma <devesh28@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Please Help me out!!
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
