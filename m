Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263166AbUDTPWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbUDTPWv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 11:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263172AbUDTPWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 11:22:51 -0400
Received: from tag.witbe.net ([81.88.96.48]:6674 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S263166AbUDTPWs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 11:22:48 -0400
Message-Id: <200404201522.i3KFMk120352@tag.witbe.net>
Reply-To: <rol@as2917.net>
From: "Paul Rolland" <rol@as2917.net>
To: "'Erik Steffl'" <steffl@bigfoot.com>, <linux-kernel@vger.kernel.org>
Subject: Re: logitech mouseMan wheel doesn't work with 2.6.5
Date: Tue, 20 Apr 2004 17:22:44 +0200
Organization: AS2917
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQm4udnEP0g7nRtS7qG7jbwn0yKqAACCNUQ
In-Reply-To: <40853060.2060508@bigfoot.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

>    it looks that after update to 2.6.5 kernel (debian source 
> package but 
> I guess it would be the same with stock 2.6.5) the mouse 
> wheel and side 
> button on Logitech Cordless MouseMan Wheel mouse do not work.
I've got a new mouse with a wheel, and I've got the same problem,
though I can't tell if it was working before...

> Here's the most basic/simple situation/symptoms:
> 
>    I stop X, read bytes from /dev/psaux (c program, using open and 
> read). for each mouse action there are few bytes read, usually number 
Could you provide me with the program so that I can test too ?

>    BTW X windows is confused in the same way (I guess because that's 
> what it gets from kernel driver - using xev I found that it 
> thinks the 
> sidebutton is button 2 and that turning the wheel is not an 
> event at all).
Got the same : wheel is no-op :-(

I guess I should try a stock 2.4.x kernel to see if it working or
not...

Regards,
Paul


