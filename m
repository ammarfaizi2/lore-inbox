Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263243AbTH0KBx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 06:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263262AbTH0KBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 06:01:53 -0400
Received: from gw-nl5.philips.com ([212.153.235.109]:25282 "EHLO
	gw-nl5.philips.com") by vger.kernel.org with ESMTP id S263243AbTH0KBw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 06:01:52 -0400
Message-ID: <3F4C81DD.6020608@basmevissen.nl>
Date: Wed, 27 Aug 2003 12:03:09 +0200
From: Bas Mevissen <ml@basmevissen.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cijoml@volny.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re: generate modprobe.conf
References: <200308271142.40104.cijoml@volny.cz>
In-Reply-To: <200308271142.40104.cijoml@volny.cz>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Semler (volny.cz) wrote:
> Hi,
> 
> I tried generate modprobe.conf from my modules.conf, but without success.
> My ethernet card and mouse doesn't work - theitr modules are not loaded in 
> startup. Where is problem?
> 

Please try something like "modprobe eth0" or "ifup eth0" and see/e-mail 
what you see in /var/log/messages.

Regards,

Bas.


