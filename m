Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbUJ0DOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbUJ0DOX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 23:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbUJ0DOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 23:14:22 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:2922 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261616AbUJ0DOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 23:14:18 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Stelian Pop <stelian@popies.net>
Subject: Re: [PATCH 0/5] Sonypi driver model & PM changes
Date: Tue, 26 Oct 2004 22:14:13 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>
References: <20041026155639.42445.qmail@web81306.mail.yahoo.com> <20041026180932.GA17655@deep-space-9.dsnet>
In-Reply-To: <20041026180932.GA17655@deep-space-9.dsnet>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410262214.13771.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 October 2004 01:09 pm, Stelian Pop wrote:
> > On the other hand I am not sure if it is handy as a ponter device -
> > I think scrolling is much more natural with the touchpad (but
> > remember I don't have the hardware)
> 
> I don't have a touchpad, just a stick. And I use the jogdial to
> scroll quite often...
> 

I wonder if the best option is to always have 2 devices and make one
corrsponding to jogdial switch between mouse-like and keyboad-like
events based on module parameter.

-- 
Dmitry
