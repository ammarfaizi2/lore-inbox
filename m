Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbULGGf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbULGGf3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 01:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbULGGf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 01:35:29 -0500
Received: from [62.206.217.67] ([62.206.217.67]:23527 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261770AbULGGfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 01:35:25 -0500
Message-ID: <41B54F1A.6050905@trash.net>
Date: Tue, 07 Dec 2004 07:35:06 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041008 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Cataldo <tomc@compaqnet.fr>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Hard freeze with 2.6.10-rc3 and QoS, worked fine with 2.6.9
References: <1102380430.6103.6.camel@buffy>
In-Reply-To: <1102380430.6103.6.camel@buffy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Cataldo wrote:

>Hi,
>
>Tonight I upgraded to 2.6.10-rc3. Everything was fine until I started
>wondershaper to setup my Qos rules :
>
>wondershaper eth0 255 16
>
>And the machine freezed hard. No magic sysrq working, no oops in my
>logs.
>  
>
Please try to find out which line causes the lockup. Are you
using the same config options as with 2.6.9 ?

Regards
Patrick
