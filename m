Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262198AbVBQDKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbVBQDKw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 22:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbVBQDKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 22:10:52 -0500
Received: from static64-74.dsl-blr.eth.net ([61.11.64.74]:21766 "EHLO
	linmail.globaledgesoft.com") by vger.kernel.org with ESMTP
	id S262198AbVBQDKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 22:10:49 -0500
Message-ID: <42140A7D.8080304@globaledgesoft.com>
Date: Thu, 17 Feb 2005 08:37:41 +0530
From: krishna <krishna.c@globaledgesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: robert@schwebel.de
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: What is a purpose of GPIO pins
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

Thank you very much.

In my board it is also used for alternate function and to wake up from 
power save.

The problem I am facing is as it is used for alternate function. My WLAN 
driver
    and the audio codec driver are conflicting.

Regards,
Krishna Chaitanya
