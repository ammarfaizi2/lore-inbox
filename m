Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283554AbRLDOoc>; Tue, 4 Dec 2001 09:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283614AbRLDOmx>; Tue, 4 Dec 2001 09:42:53 -0500
Received: from albatross-ext.wise.edt.ericsson.se ([194.237.142.116]:40363
	"EHLO albatross-ext.wise.edt.ericsson.se") by vger.kernel.org
	with ESMTP id <S283112AbRLDM24>; Tue, 4 Dec 2001 07:28:56 -0500
Message-ID: <3C0CCDAD.BC8F01B8@uab.ericsson.se>
Date: Tue, 04 Dec 2001 14:20:46 +0100
From: Simona <Toma.Simona@uab.ericsson.se>
Reply-To: Toma.Simona@uab.ericsson.se
Organization: UAB
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Netfilter hooks.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


I am implementing a kernel module for taking a packet out from the stack
at the IP level, redistributing the packet to another stack and puting
the packet into the new stack.

Question: do I need to register a target for this?
Can I call a hook in the same way that I am getting called if I am
registering to a hook?


