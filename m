Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271973AbTGYKcT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 06:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272004AbTGYKcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 06:32:19 -0400
Received: from gw-nl5.philips.com ([212.153.235.109]:139 "EHLO
	gw-nl5.philips.com") by vger.kernel.org with ESMTP id S271973AbTGYKcR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 06:32:17 -0400
Message-ID: <3F210AF9.4030606@basmevissen.nl>
Date: Fri, 25 Jul 2003 12:48:25 +0200
From: Bas Mevissen <ml@basmevissen.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: time for some drivers to be removed?
References: <Pine.LNX.4.53.0307240817520.19533@localhost.localdomain>	 <1059058737.7994.25.camel@dhcp22.swansea.linux.org.uk>	 <3F1FFC94.7080409@basmevissen.nl> <1059073642.7993.31.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1059073642.7993.31.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> The OBSOLETE stuff is already used on a couple of drivers that are obsolete
> since 2.2 (although I fixed two of them as they got fixed in 2.4 in the
> end)
> 

O.K. So if something is marked obsolete, you need to edit some config 
file to make it to (try to) compile again.

Making it a config option doesn't make sense as you are going to edit 
things anyway. (if I assume that obsolete stuff is mostly broken TOO).

Regards,

Bas.


