Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269017AbUICEIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269017AbUICEIA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 00:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269033AbUICEIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 00:08:00 -0400
Received: from hacksaw.org ([66.92.70.107]:16575 "EHLO hacksaw.org")
	by vger.kernel.org with ESMTP id S269017AbUICEH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 00:07:59 -0400
Message-Id: <200409030407.i8347hlG011496@hacksaw.org>
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.0.4
To: Spam <spam@tnonline.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: The argument for fs assistance in handling archives 
In-reply-to: Your message of "Thu, 02 Sep 2004 22:06:03 +0200."
             <16310213029.20040902220603@tnonline.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 Sep 2004 00:07:43 -0400
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>If tar is patched then it would be no
>problem and no extra stuff but perhaps a switch --save-metas.

Aaargh. How about a tar that recognizes when the filesystem has metas and 
saves/restores them by default, with a warning when it's losings data because 
it's restoring to a simpler filesystem?

And maybe a switch --forget-metas.

Thousands of sys-admins will thank you to not make it easier to lose data with 
the scripts they have already written.


-- 
You are in a maze of twisty passages, all alike. Again. 
http://www.hacksaw.org -- http://www.privatecircus.com -- KB1FVD


