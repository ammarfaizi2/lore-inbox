Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266627AbUIOCVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266627AbUIOCVy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 22:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266749AbUIOCVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 22:21:54 -0400
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:34943 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266627AbUIOCVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 22:21:53 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Mouse Problems with 2.6
Date: Tue, 14 Sep 2004 21:21:49 -0500
User-Agent: KMail/1.6.2
Cc: r2 <torsten.foertsch@gmx.net>
References: <200409142344.00646.r2@opi.home>
In-Reply-To: <200409142344.00646.r2@opi.home>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409142121.50186.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 September 2004 04:43 pm, r2 wrote:
> I'd also like to get the old kernel 2.4 touchpad behaviour. With 2.4 the it
> had sent a Button1 event by simply touching it. Now I have to press the
> appropriate button.
>

http://w1.894.telia.com/~u89404340/touchpad/index.html to enjoy all features
of your fine touchpad.
 
> I have seen the module parameter "proto" in the source. Is it worth to play
> with it?
> 

That's another option - psmouse.proto=bare will restore tapping as well.

-- 
Dmitry
