Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263266AbTH0KdT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 06:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263276AbTH0KdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 06:33:19 -0400
Received: from gw-nl5.philips.com ([212.153.235.109]:50127 "EHLO
	gw-nl5.philips.com") by vger.kernel.org with ESMTP id S263266AbTH0KdR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 06:33:17 -0400
Message-ID: <3F4C893B.5030203@basmevissen.nl>
Date: Wed, 27 Aug 2003 12:34:35 +0200
From: Bas Mevissen <ml@basmevissen.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cijoml@volny.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re: generate modprobe.conf
References: <200308271142.40104.cijoml@volny.cz> <3F4C81DD.6020608@basmevissen.nl> <200308271206.35069.cijoml@volny.cz>
In-Reply-To: <200308271206.35069.cijoml@volny.cz>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Semler (volny.cz) wrote:

> When I load it manually and ifconfig it, device works...
> 
> I don't know why, coz 
> 
> alias eth0 3c59x
> 
> and
> 
> alias char-major-13 hid
> post-install hid modprobe -k mousedev; modprobe -k input
> 
> is a standart way...isn't it?
> 

Hmmm. Strange. But it doesn't look like a kernel problem, but a system 
configuration problem. So I'll take this off LKML and see if I can help 
you by private e-mail.

Regards,

Bas.



