Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbVK1VQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbVK1VQG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 16:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbVK1VQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 16:16:06 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:11184 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S932079AbVK1VQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 16:16:04 -0500
Date: Mon, 28 Nov 2005 19:15:57 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       akpm <akpm@osdl.org>, ehabkost@mandriva.com
Subject: [RESEND 0/2] - usbserial: Adds missing checks and bug fix.
Message-Id: <20051128191557.5076797b.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi Greg,

 I'm re-sending two patches I sent to you last week, because I guess they get
lost in the e-mail thread.

 The first patch adds missing checks in the usb-serial driver which can
avoid NULL pointer dereferences. The second one fixes a race-condition.

 Both patches have the full description, and by your comments, you were
inclined to accept them I guess.

 Thank you,

-- 
Luiz Fernando N. Capitulino
