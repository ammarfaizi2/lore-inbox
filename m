Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269776AbTGOWC1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 18:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269785AbTGOWC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 18:02:27 -0400
Received: from [192.188.53.79] ([192.188.53.79]:19204 "EHLO mailbk.usfq.edu.ec")
	by vger.kernel.org with ESMTP id S269776AbTGOWC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 18:02:26 -0400
Message-ID: <3F147B8F.5000103@mail.usfq.edu.ec>
Date: Tue, 15 Jul 2003 17:09:19 -0500
From: Fernando Sanchez <fsanchez@mail.usfq.edu.ec>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: modules problems with 2.6.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been trying to get 2.6.0 to work, I've enabled modules support, but 
I get this error on my logs:

Jul 15 15:38:36 Darakemba kernel: No module symbols loaded - kernel 
modules not enabled.

Is there any thing like a new modutils that should be used with 2.6.x 
family?

The kernel does boot, but not having any modules I can't do much, and 
also, I never get to really see the messages on screen, on logs I have 
this line:

Jul 15 15:38:36 Darakemba kernel: Video mode to be used for restore is ffff

What does it mean?

I disabled all the framebuffer things so I can just use vga, on lilo, 
vga mode is set to normal, but still can't see anything.


TIA,



-- 


Fernando Sanchez
Dpto. Sistemas USFQ



