Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751646AbWFUPSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbWFUPSR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 11:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbWFUPSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 11:18:17 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:21516 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751646AbWFUPSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 11:18:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=rBqKacYvoJkNgYZ1IgwezO7fnX5ZRSF8+B7orVFEXoeSmcaMh0Row8Ua2FaDALpQ7/w9YfX8GAHPQJzQMaRVIOywdS++UVEgk2/XhdIQ57DouXkLj4/GdYxV77XgTNahCvXP2XYuHIaYLE+touRgEiODkdKDRipnw+PnKOBB/AU=
Message-ID: <44996332.5090408@gmail.com>
Date: Wed, 21 Jun 2006 23:18:10 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_VGACON_SOFT_SCROLLBACK crashes 2.6.17
References: <200606211715.58773.a1426z@gawab.com>
In-Reply-To: <200606211715.58773.a1426z@gawab.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> Enabling CONFIG_VGACON_SOFT_SCROLLBACK causes random fatal system freezes.
> 
> Especially, ping 10.1 -A easily causes a complete system hang during scroll.
> 
> Is there an easy way to fix this, other than disabling the option?

I can't duplicate your problem. Did it ever work before?

Can you send me you kernel config?

Tony
