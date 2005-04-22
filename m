Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVDVXwC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVDVXwC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 19:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVDVXwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 19:52:01 -0400
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:62376 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261338AbVDVXvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 19:51:53 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Graham Seale <graham@southline.net>
Subject: Re: 2.6 kernel, 2.4 kernel, keyboard input handling
Date: Fri, 22 Apr 2005 18:51:50 -0500
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <42697BAE.9020902@southline.net>
In-Reply-To: <42697BAE.9020902@southline.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504221851.50703.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday 22 April 2005 17:33, Graham Seale wrote:
> 
> The loss of keyboard function is independent of the environment, whether 
> using GUI applications (various) or command line only.
> 
> The response of the 2.4 kernel is much more able to re-establish 
> keyboard polling sync. Generally, as the Linux GUI is restored, there 
> are random input states that might bring up the menu (unasked), and this 
> will go away after one or two mouse clicks on the screen. If a "freeze" 
> does happen, it may be cleared by switching away, then back to the Linux PC.
> 

I am a bit confused here... You are saying "loss of keyboard function"
but then mention mouse clicks. What is that you lose - keyboard or mouse
or both?

We know about problems with KVMs and mice but keyboards usually work just
fine with 2.6... 

-- 
Dmitry
