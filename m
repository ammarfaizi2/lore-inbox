Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275816AbRJQMl5>; Wed, 17 Oct 2001 08:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275818AbRJQMlr>; Wed, 17 Oct 2001 08:41:47 -0400
Received: from maties1.sun.ac.za ([146.232.128.1]:6584 "EHLO maties1.sun.ac.za")
	by vger.kernel.org with ESMTP id <S275816AbRJQMli>;
	Wed, 17 Oct 2001 08:41:38 -0400
Date: Wed, 17 Oct 2001 14:41:58 +0200
To: linux-kernel@vger.kernel.org
Subject: ps/2 mouse, keyboard conflicts
Message-ID: <20011017144158.A6534@baboon.wilgenhof.sun.ac.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
From: Hugo van der Merwe <hugovdm@mail.com>
X-Scanner: exiscan *15tq1L-0005gN-00*5tpFa4b0vBo* http://duncanthrax.net/exiscan/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When I enable the ps/2 mouse, I get some kind of conflict between it and
the keyboard (usually only after using them both for a while) resulting
in both going ... "dead". The serial mouse still works though. Disabling
the ps/2 mouse and unloading the module does sort it out again. (This I
do over the network ;)

Any ideas how I can debug this problem?

Thanks,
Hugo van der Merwe
