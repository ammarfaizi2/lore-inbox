Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262909AbUB0PHo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 10:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbUB0PHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 10:07:43 -0500
Received: from mail.oatmail.org ([198.145.35.3]:6929 "EHLO mail.oatmail.org")
	by vger.kernel.org with ESMTP id S262909AbUB0PHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 10:07:41 -0500
Message-ID: <403F5D3A.4080101@oatmail.org>
Date: Fri, 27 Feb 2004 07:07:38 -0800
From: Brad Davidson <kiloman@oatmail.org>
User-Agent: Mozilla Thunderbird 0.5a (20031216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: drivers/ieee1394/sbp2.c:734: error: `host' undeclared (first
 use in this function) 2.6.3-bk3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

This is the same change I made in my local tree against 2.6.3-bk4. It 
was pretty much a blind change, so I have no idea if it's the right 
thing to do or not, but it certainly compiles now. I've connected a few 
firewire devices and they appear to work as expected without anything 
going belly-up, so it's good enought for me. I guess only Bob really 
knows if that's what he meant.

I'm not subscribed to the list, reply to me personally, etc etc etc.

 > I've no hardware to test this, but does this do the right thing for you ?
 > Dave

 > < patch converting host to hi->host >
