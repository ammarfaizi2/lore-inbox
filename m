Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264181AbRFRPP4>; Mon, 18 Jun 2001 11:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264176AbRFRPPq>; Mon, 18 Jun 2001 11:15:46 -0400
Received: from [207.0.237.38] ([207.0.237.38]:22276 "HELO sin.sloth.org")
	by vger.kernel.org with SMTP id <S264169AbRFRPPa>;
	Mon, 18 Jun 2001 11:15:30 -0400
Date: Mon, 18 Jun 2001 11:15:11 -0400
From: Geoffrey Gallaway <geoffeg@sin.sloth.org>
To: linux-kernel@vger.kernel.org
Subject: Error in documentation?
Message-ID: <20010618111510.A27662@sin.sloth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux/Documentation/modules.txt says that I should find my modules in
"linux/modules" after running "make modules". However, this is
apparently not true as I see no modules directory. 

I am trying to compile a kernel with lots of modules for a machine
without a network connection. To move the kernel, I simply copy it to
floppy and move it over to the other machine. However, for the modules,
is my only choice appears to be "make modules-install" then tar up
/lib/modules/kernel-release/ and then remove the directory. Is there a 
cleaner way to handle this?

Geoffeg

-- 
Geoffrey Gallaway || 
geoffeg@sloth.org || Clones are people two.
D e v o r z h u n ||
