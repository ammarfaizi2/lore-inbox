Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbUEaJtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbUEaJtk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 05:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbUEaJtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 05:49:40 -0400
Received: from web51007.mail.yahoo.com ([206.190.38.138]:29064 "HELO
	web51007.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261205AbUEaJtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 05:49:39 -0400
Message-ID: <20040531094939.74138.qmail@web51007.mail.yahoo.com>
Date: Mon, 31 May 2004 02:49:39 -0700 (PDT)
From: Shobhit Mathur <shobhitmmathur@yahoo.com>
Subject: [LKML]kmalloc -contiguous locations ?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I would like to know whether kmalloc() guarantees
virtually contiguous memory locations ? 
Is there a limit on the amount of contiguous memory
that can be returned by kmalloc() ?

- Thank you

- Shobhit Mathur


	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 
