Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbVIZN56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbVIZN56 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 09:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbVIZN56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 09:57:58 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:6184 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932129AbVIZN56 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 09:57:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=aa4owgZd/RbOqEqi9GkaP0+405QOEvBOyEFlV+kOUYYeIvkpG3D1Ot4ltwL4/aVBoPmWS7IcVdNWnZB9sE1tAJgcNiU5n7F1jQc/h6pYRgnSJ9wPu+4ODFINxTTQ+LYtU2LXS+h6vGCg3cnSDr4UNnSq3mZAWiZGA4d/lWTjFGI=
Message-ID: <4337FE60.5070308@gmail.com>
Date: Mon, 26 Sep 2005 15:57:52 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.4 (X11/20050908)
MIME-Version: 1.0
To: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Automatic Configuration of a Kernel
References: <20050926120850.30349.qmail@web51012.mail.yahoo.com>
In-Reply-To: <20050926120850.30349.qmail@web51012.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Ahmad Reza Cheraghi wrote:
> Hi folks,
>
> For my EndThesis, in the Niederrhein University of
> Applied Sciences, I've almost finished a framework
> that generates a .config file based on the target
> system.This program should help people to generate a
> linux kernel Config without spending a lot of time at
> the configuration.
>   
[snip]
> Any comments and suggestions are welcome !
>
>
> Regards
> Ahmad Reza Cheraghi
>   
Can you put this patch set on any server?
I know it's probably my thunderbird problem, but when I'm tring
to apply your patches I've got:
patch: **** malformed patch at line 38: 128);

Regards,
Michal Piotrowski
