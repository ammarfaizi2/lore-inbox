Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262201AbVCDG3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbVCDG3M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 01:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbVCDG3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 01:29:11 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:29582 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262201AbVCDG3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 01:29:02 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Leonid Petrov <nouser@lpetrov.net>
Subject: Re: 2.6.11 ps/2 mouse is dead
Date: Fri, 4 Mar 2005 01:28:57 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <4227F7B8.nail79Z11S4KM@lpetrov.net>
In-Reply-To: <4227F7B8.nail79Z11S4KM@lpetrov.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503040128.58255.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 March 2005 00:52, Leonid Petrov wrote:
> I upgraded from 2.6.10 to 2.6.11 using "make oldconfig" and my 
> Logitech ps/2 mouse is dead. cat /dev/input/mice shows 
> nothing. Nothing suspicios in /var/log/messages
> The same mousce works fine with 2.6.10
> 

Does it work with i8042.noacpi kernel boot option?

-- 
Dmitry
