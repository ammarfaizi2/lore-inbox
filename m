Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132434AbRDSSbl>; Thu, 19 Apr 2001 14:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132616AbRDSSbc>; Thu, 19 Apr 2001 14:31:32 -0400
Received: from [213.97.184.209] ([213.97.184.209]:1152 "HELO piraos.com")
	by vger.kernel.org with SMTP id <S132434AbRDSSbV>;
	Thu, 19 Apr 2001 14:31:21 -0400
Date: Thu, 19 Apr 2001 20:31:19 +0200 (CEST)
From: German Gomez Garcia <german@piraos.com>
To: Mailing List Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Problems with i2c-matroxfb and latest kernel
Message-ID: <Pine.LNX.4.21.0104192028050.259-100000@hal9000.piraos.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

	After downloading latest 2.4.3-ac9 kernel and compiling it I found
that when I insert the i2c-matroxfb module, the modprobe utility
completely monopolize the system during about a minute everything gets
really slow and it seems that it do something on the virtual consoles
during this time, because if I change virtual console my monitor gets out
of sync for an instant, the same that happens when you have the consoles
set to different resolution/refresh rate. Everything gets fixed after it
load. 

	Any clue?

	- german

PS: Please CC'd to me as I'm not subscribed to the list.
-------------------------------------------------------------------------
German Gomez Garcia         | "This isn't right.  This isn't even wrong."
<german@piraos.com>         |                         -- Wolfgang Pauli

