Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264248AbTDWTY7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 15:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264259AbTDWTWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 15:22:49 -0400
Received: from marshall.modwest.com ([216.129.251.30]:4519 "EHLO
	mail.modwest.com") by vger.kernel.org with ESMTP id S264408AbTDWTWO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 15:22:14 -0400
From: Nils Holland <nils@ravishing.de>
Organization: Ravishing Enterprises
To: David van Hoose <davidvh@cox.net>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.21-rc1] USB Trackball broken
Date: Wed, 23 Apr 2003 21:34:42 +0200
User-Agent: KMail/1.5.1
References: <3EA6C558.5040004@cox.net>
In-Reply-To: <3EA6C558.5040004@cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304232134.42349.nils@ravishing.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 April 2003 18:54, David van Hoose wrote:

> I am running RedHat 9. Trackball is detected and works when using the
> stock 2.4.20-9 kernel that RedHat provided.
>
> With 2.4.21-rc1, I have included the USB and input devices in the
> kernel, as modules, and as various combinations in between. My USB
> Logitech Trackball shows up as being detected and setup, but it doesn't
> work.

I'm using a Logitech Cordless TrackMan here, and this works fine with 
2.4.21-rc1. I don't know which trackball you have, but the Logitech input 
devices all seem to be using more or less the same receiver, and this is what 
the problem would be about.

Anyway, if not done already, I would suggest that you plug the trackball right 
into one of the computer's USB ports and not into an external hub to see if 
that makes a difference.

Greetings
Nils

-- 
celine.ravishing.de
Linux 2.4.21-rc1 #5 Tue Apr 22 13:12:21 CEST 2003 i686
  9:30pm  up  2:10,  2 users,  load average: 0.00, 0.02, 0.00

