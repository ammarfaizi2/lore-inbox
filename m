Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271159AbTHCMM7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 08:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271163AbTHCMM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 08:12:59 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:3575 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S271159AbTHCMM6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 08:12:58 -0400
Message-ID: <3F2CFC80.4090401@softhome.net>
Date: Sun, 03 Aug 2003 14:13:52 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Werner Almesberger <werner@almesberger.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: TOE brain dump
References: <g83n.8vu.9@gated-at.bofh.it>
In-Reply-To: <g83n.8vu.9@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:
> 
>  - instead of putting a different stack on the TOE, a
>    general-purpose processor (probably with some enhancements,
>    and certainly with optimized data paths) is added to the NIC
> 

    Modern NPUs generally do this.
    You need to have something like this to handle e.g. routing of GE 
traffic.

    Check for example: 
http://www.vitesse.com/products/categories.cfm?family_id=5&category_id=16

