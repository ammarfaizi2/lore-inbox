Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261488AbTCTOkk>; Thu, 20 Mar 2003 09:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261492AbTCTOkk>; Thu, 20 Mar 2003 09:40:40 -0500
Received: from hal-4.inet.it ([213.92.5.23]:49114 "EHLO hal-4.inet.it")
	by vger.kernel.org with ESMTP id <S261488AbTCTOkj> convert rfc822-to-8bit;
	Thu, 20 Mar 2003 09:40:39 -0500
Content-Type: text/plain; charset=US-ASCII
From: Paolo Ornati <javaman@katamail.com>
To: linux-kernel@vger.kernel.org
Subject: HELP: Building System
Date: Thu, 20 Mar 2003 15:50:49 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030320144039Z261488-25575+33284@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think that the available Documentetion about "REcompiling a kernel" is a 
little confusing (about the use of "make clean").

EXAMPLES:

source: "The Linux Kernel HOWTO"
...When the configure script ends, it also tells you to `make dep' and 
(possibly) `clean'...

...For older versions of the kernel, when finished, you should do a `make 
clean'...

...In any case, do not forget this step before attempting to recompile a 
kernel. 

	possibly?
	only for older versions of kernel?
	in any case?
	WHEN?

source: www.linuxchix.org
...Sometimes, you'll change things so much that "make" can't figure out how 
to recompile the files correctly. "make clean" will remove all the object 
files (ending in .o) and a few other things...

	ok, this seems more convincing...

Can anyone be more clear?

Bye,
Paolo

