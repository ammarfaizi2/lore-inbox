Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263601AbUDMPhq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 11:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263558AbUDMPhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 11:37:45 -0400
Received: from krl.krl.com ([192.147.32.3]:5770 "EHLO krl.krl.com")
	by vger.kernel.org with ESMTP id S263606AbUDMPhW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 11:37:22 -0400
Message-Id: <200404131537.i3DFb8JE004356@p-chan.krl.com>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4
To: John Cherry <cherry@osdl.org>
cc: linux-kernel@vger.kernel.org, aardvark@p-chan.krl.com
Subject: Re: IA32 (2.6.5 - 2004-04-12.22.30) - 2 New warnings (gcc 3.2.2) 
In-Reply-To: Message from John Cherry <cherry@osdl.org> 
   of "Tue, 13 Apr 2004 07:31:38 PDT." <200404131431.i3DEVcCg010071@cherrypit.pdx.osdl.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Apr 2004 11:37:08 -0400
From: Don Koch <aardvark@krl.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> drivers/char/cyclades.c:686: warning: `cy_get_user' defined but not used
I sent a patch for this to the janitor's list.

-- 
Don Koch
http://www.krl.com/


