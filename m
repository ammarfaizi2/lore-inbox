Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274961AbTHMNgQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 09:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274991AbTHMNgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 09:36:15 -0400
Received: from baloney.puettmann.net ([194.97.54.34]:19130 "EHLO
	baloney.puettmann.net") by vger.kernel.org with ESMTP
	id S274961AbTHMNgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 09:36:04 -0400
Date: Wed, 13 Aug 2003 15:35:06 +0200
To: Damian Ko?kowski <deimos@deimos.one.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 APM problems with IBM Thinkpad's
Message-ID: <20030813133506.GB26337@puettmann.net>
References: <20030813123119.GA25111@puettmann.net> <20030813131043.GA1112@deimos.one.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030813131043.GA1112@deimos.one.pl>
User-Agent: Mutt/1.5.4i
From: Ruben Puettmann <ruben@puettmann.net>
X-Scanner: exiscan *19mvmM-0006w1-00*UMS9rg8XDL6* (Puettmann.NeT, Germany)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 03:10:43PM +0200, Damian Ko?kowski wrote:
> 
> Please send my your confog for 2.4.22-rc2, so I can help you.
> 
> Take care.
> 
> P.S. Have you run apcid or apmd?
> 
 I have try acpid with an acpi config but acpi is broken see :

http://bugzilla.kernel.org/show_bug.cgi?id=1038

but I hope it will run in the next weeks.

With apm I have running the apmd.

apm config: 

CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_RTC_IS_GMT is not set
CONFIG_APM_ALLOW_INTS=y
# CONFIG_APM_REAL_MODE_POWER_OFF is not set


        ruben

-- 
Ruben Puettmann
ruben@puettmann.net
http://www.puettmann.net
