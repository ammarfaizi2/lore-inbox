Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262505AbUJ0Q3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262505AbUJ0Q3O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 12:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262506AbUJ0Q2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 12:28:31 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:30111 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262508AbUJ0QYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 12:24:06 -0400
Subject: Re: IDE warning: "Wait for ready failed before probe!"
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alan Jenkins <aj504@york.ac.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1098819302l.9064l.1l@localhost>
References: <1098564453l.9607l.0l@localhost>
	 <1098819302l.9064l.1l@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098890478.7284.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 27 Oct 2004 16:21:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-10-26 at 20:35, Alan Jenkins wrote:
> I have no problems (I hope!), but the warnings I get when linux (2.6.9) 
> tries to probe a non existant IDE device (controller/channel (?) not  
> hard disk) are slightly over the top..

They are KERN_DEBUG, and they can probably just go away now.


