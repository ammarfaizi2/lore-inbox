Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262353AbVAOWwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbVAOWwT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 17:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbVAOWwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 17:52:18 -0500
Received: from pat.uio.no ([129.240.130.16]:57589 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262353AbVAOWwQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 17:52:16 -0500
Subject: Re: make flock_lock_file_wait static
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Adrian Bunk <bunk@stusta.de>
Cc: Arjan van de Ven <arjan@infradead.org>, viro@zenII.uk.linux.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050115213515.GQ4274@stusta.de>
References: <20050109194209.GA7588@infradead.org>
	 <1105310650.11315.19.camel@lade.trondhjem.org>
	 <1105345168.4171.11.camel@laptopd505.fenrus.org>
	 <1105346324.4171.16.camel@laptopd505.fenrus.org>
	 <1105367014.11462.13.camel@lade.trondhjem.org>
	 <1105432299.3917.11.camel@laptopd505.fenrus.org>
	 <1105471004.12005.46.camel@lade.trondhjem.org>
	 <20050115213515.GQ4274@stusta.de>
Content-Type: text/plain
Date: Sat, 15 Jan 2005 17:07:17 -0500
Message-Id: <1105826837.10279.1.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lau den 15.01.2005 Klokka 22:35 (+0100) skreiv Adrian Bunk:

> My figures in [1] show, any kind of deprecation would mean _much_ extra 
> work within the current 2.6 development model.

Whereas removal of necessary APIs would not? Thanks...

Cleanups are important, but so is actual development....

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

