Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265304AbRFVANl>; Thu, 21 Jun 2001 20:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265306AbRFVANb>; Thu, 21 Jun 2001 20:13:31 -0400
Received: from gannet.scg.man.ac.uk ([130.88.94.110]:49424 "EHLO
	gannet.scg.man.ac.uk") by vger.kernel.org with ESMTP
	id <S265304AbRFVANV>; Thu, 21 Jun 2001 20:13:21 -0400
Date: Fri, 22 Jun 2001 01:13:17 +0100
From: John Levon <moz@compsoc.man.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Possibly stupid sysctl question
Message-ID: <20010622011317.A26141@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.19i
X-Url: http://www.movement.uklinux.net/
X-Record: I Am Kloot - Natural History
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If I am using a sysctl directory when the relevant unregister_sysctl_table()
is called, the directory and parent directories will continue to exist. Fine.

However when I cd out of the dir, the directory does not disappear.

When/where do sysctl directories get collected ?

thanks
john

-- 
"Euler's equation contains the five most important numbers in mathematics."
