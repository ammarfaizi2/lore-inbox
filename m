Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266795AbTAZK3R>; Sun, 26 Jan 2003 05:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266796AbTAZK3R>; Sun, 26 Jan 2003 05:29:17 -0500
Received: from smtp.laposte.net ([213.30.181.7]:46521 "EHLO smtp.laposte.net")
	by vger.kernel.org with ESMTP id <S266795AbTAZK3R>;
	Sun, 26 Jan 2003 05:29:17 -0500
Message-ID: <3E33C8D0.1080200@chantret.com>
Date: Sun, 26 Jan 2003 11:38:56 +0000
From: CHANTRET Florent <florent@chantret.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.1) Gecko/20020826
X-Accept-Language: fr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SMBALERT# on VAIO Serie F solved !!!
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

Just for information if some people having the same problem as me take a 
look on the kernel ML archive, the problem of spontaneous shutdown on 
VAIO serie F laptop can be solved easily :

You just have to pass

apm=off no-hlt

to the kernel at boot-time.

Regards,
Florent CHANTRET

