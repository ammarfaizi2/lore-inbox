Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292180AbSBTSeC>; Wed, 20 Feb 2002 13:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292181AbSBTSdx>; Wed, 20 Feb 2002 13:33:53 -0500
Received: from [62.47.19.142] ([62.47.19.142]:4993 "HELO twinny.dyndns.org")
	by vger.kernel.org with SMTP id <S292180AbSBTSdq>;
	Wed, 20 Feb 2002 13:33:46 -0500
Message-ID: <3C73EBD2.2116ECA8@webit.com>
Date: Wed, 20 Feb 2002 19:32:50 +0100
From: Thomas Winischhofer <tw@webit.com>
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en,en-GB,en-US,de-AT,de-DE,de-CH,sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Jean Paul Sartre <sartre@linuxbr.com>
Subject: Re: A simple patch for SIS (documentation and kbuild)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Paul Sartre wrote:

+SiS 300/540/630
+CONFIG_DRM_SIS
+  Choose this option if you have a SIS 300, 540 or 630 graphics card.
+  If M is selected, the module will be called sis.o.  AGP support is
+  required for this driver to work.

Before posting patches you'd better inform yourself. 

AGP is *not* required.

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
mailto:tw@webit.com                  *** http://www.webit.com/tw
