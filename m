Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268529AbUHLM3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268529AbUHLM3z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 08:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268531AbUHLM3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 08:29:55 -0400
Received: from mail6.centrum.cz ([213.29.7.198]:35264 "EHLO mail6.centrum.cz")
	by vger.kernel.org with ESMTP id S268529AbUHLM3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 08:29:53 -0400
Date: Thu, 12 Aug 2004 11:36:40 +0200
From: "Jakub Vana" <gugux@centrum.cz>
To: <linux-kernel@vger.kernel.org>
X-Mailer: Centrum Mail 1.0
MIME-Version: 1.0
X-Priority: 3
Subject: x86 - Realmode BIOS and Code calling module
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: 8bit
Message-Id: <20040812093653Z2097836-29040+39160@mail.centrum.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have written Linux Kernel module that allows you to call BIOS interupts, Far services or your own code. It's working on x86 machines with PAE or not PAE enabled(up to 4GB or up to 64GB). It's tested on 2.4.26 and 2.6.7 kernel on P4 machine. I think there is not problem to work on others. Now, I'm preparing DOCs and Demos.

I wrote the module especialy for changing the VESAFB videomode, but It is usable anywhere the BIOS is neaded.

I'm writing you to know this code exists and to ask you for help to add this code to official Kernel distribution.

Thank you

Jakub Vana

--------------------
Pøipravte se! Je tu ¹kola. Nav¹tivte vèas Palác Flóra. Od 20.srpna do 5.záøí probíhá v Paláci Flóra speciální trh ¹kolních potøeb. http://user.centrum.cz/redir.php?url=http://www.palacflora.com



