Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbVIQC07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbVIQC07 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 22:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbVIQC07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 22:26:59 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:65495 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750779AbVIQC06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 22:26:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ZXxXulACI8h1y3hP3MJBwMqP9ZrCOo4YaUrWp6HEDgVHNJT3qQwwymcKqCAMV2KQhY7oz+Zze1M9qncF8Nc2CSPa5NIoWmUDl9aVG/sIec2wlqba0z18jikuPTZhkNI7cZAJ+Ld+sHAJ+bQnZxmTknf5im60rrWeSIl/+7l62Is=
Message-ID: <432B7EE6.1040905@gmail.com>
Date: Fri, 16 Sep 2005 22:26:46 -0400
From: Keenan Pepper <keenanpepper@gmail.com>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@novell.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: R52 hdaps support?
References: <432B34D6.6010904@gmail.com> <1126911860.24266.1.camel@phantasy>
In-Reply-To: <1126911860.24266.1.camel@phantasy>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> The R52 should work and nothing should break.  If it works, I'll add it.
> 
> As for normal versus inverted: You probably want NORMAL, but you will
> have to verify it and let me know.  You'll know you have the wrong one
> when the readings are, well, inverted.
> 
> 	Robert Love

OK, it's compiled and running, but how do I tell if it's inverted? The laptop is 
on a horizontal surface and /sys/devices/platform/hdaps/position reads 
(482,508). What does that mean?

Keenan Pepper
