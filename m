Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932832AbWGBTYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932832AbWGBTYz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 15:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932841AbWGBTYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 15:24:55 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:46087 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S932832AbWGBTYy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 15:24:54 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Jordi Pina <pinucset@gmail.com>
Subject: Re: Webcam in Sony Vaio FE21S
Date: Sun, 2 Jul 2006 20:25:21 +0100
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200607022110.15696.pinucset@gmail.com>
In-Reply-To: <200607022110.15696.pinucset@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607022025.21101.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 02 July 2006 20:10, Jordi Pina wrote:
> Hi,
>
> I have a Sony Vaio FE21S Laptop wich has a webcam, it's detected like this:
>
> Bus 005 Device 003: ID 0ac8:c002 Z-Star Microelectronics Corp.

A bit of googling and it looks like this camera might use an Spca/Zr chipset, 
which are supported by http://mxhaard.free.fr/spca5xx.html

That said, your camera isn't listed specifically, so it might need some work. 
Probably worth contacting the maintainer about it.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
