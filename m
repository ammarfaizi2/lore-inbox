Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265441AbVBESTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265441AbVBESTo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 13:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265430AbVBESTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 13:19:43 -0500
Received: from fire.osdl.org ([65.172.181.4]:29151 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S270435AbVBESLs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 13:11:48 -0500
Message-ID: <42050A39.4040307@osdl.org>
Date: Sat, 05 Feb 2005 10:02:33 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Justin Piszcz <jpiszcz@lucidpixels.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Simple question regarding loop devices.
References: <Pine.LNX.4.62.0502051233410.13241@p500>
In-Reply-To: <Pine.LNX.4.62.0502051233410.13241@p500>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:
> Why are there only 7-8 loop devices available?
> What options do I have if I want to mount, say, 100 isos?

Documentation/kernel-parameters.txt say:

max_loop=       [LOOP] Maximum number of loopback devices that can
		be mounted
		Format: <1-256>

-- 
~Randy
