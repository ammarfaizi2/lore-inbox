Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265058AbUEVDJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265058AbUEVDJl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 23:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265063AbUEVDJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 23:09:41 -0400
Received: from 10.69-93-172.reverse.theplanet.com ([69.93.172.10]:6024 "EHLO
	gsf.ironcreek.net") by vger.kernel.org with ESMTP id S265058AbUEVDJi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 23:09:38 -0400
Message-ID: <40AEC430.7070907@eisenbach.com>
Date: Fri, 21 May 2004 20:08:32 -0700
From: Andre Eisenbach <andre@eisenbach.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: live power to usb cable
References: <1085082330.8372.43.camel@amsa>
In-Reply-To: <1085082330.8372.43.camel@amsa>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geoff Mishkin wrote:

>On my USB cables that have connectors on both ends, one end is live when
>the other end is plugged into the computer.  
>
Try re-compiling the kernel without CONFIG_USB_CATTLE_PROD.

  André
