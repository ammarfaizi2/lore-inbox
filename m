Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264026AbTDOBZU (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 21:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264027AbTDOBZU (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 21:25:20 -0400
Received: from fep04-mail.bloor.is.net.cable.rogers.com ([66.185.86.74]:38118
	"EHLO fep04-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S264026AbTDOBZT 
	(for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 21:25:19 -0400
Subject: Re: FBCON - vesa graphics modes no longer work on Toshiba Laptop
From: Sean Estabrooks <seanlkml@rogers.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1050336424.32705.31.camel@linux1.classroom.com>
References: <1050336424.32705.31.camel@linux1.classroom.com>
Content-Type: text/plain
Organization: 
Message-Id: <1050370624.29655.5.camel@linux1.classroom.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 14 Apr 2003 21:37:04 -0400
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep04-mail.bloor.is.net.cable.rogers.com from [24.102.213.170] using ID <seanlkml@rogers.com> at Mon, 14 Apr 2003 21:37:04 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-14 at 12:07, Sean Estabrooks wrote:

> 2.5.67 kernel with vga=0x305 sets a graphic mode that only uses the
> inner 640x480 set of pixels and the display is just a jumbled mess.  
> 

Why don't you add vga=791 video=vesa:1024x768 to the kernel boot line
and enjoy.  And next time maybe you should try to figure it out for
yourself just a little bit longer before asking the list.

Regards,
Sean.


