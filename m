Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266060AbTLISXv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 13:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266043AbTLISXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 13:23:50 -0500
Received: from [192.35.37.50] ([192.35.37.50]:42222 "EHLO
	enterprise.atl.lmco.com") by vger.kernel.org with ESMTP
	id S266042AbTLISWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 13:22:37 -0500
Message-ID: <3FD612E2.90607@atl.lmco.com>
Date: Tue, 09 Dec 2003 13:22:26 -0500
From: Aron Rubin <arubin@atl.lmco.com>
Organization: Lockheed Martin ATL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031021
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mickael Marchand <marchand@kde.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Silicon image 3114 SATA link (really basic support)
References: <20031203204445.GA26987@gtf.org> <200312051842.26599.marchand@kde.org> <3FD0C4B0.8020106@pobox.com> <200312051907.13727.marchand@kde.org>
In-Reply-To: <200312051907.13727.marchand@kde.org>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mickael Marchand wrote:
> here it is ;) (for 2.6.0-test11)
> it includes patches in siimage.c but it did not work IIRC (lost interrupt).
> (don't compile siimage inside the kernel, it would not boot)

Your messages seem to be conflicting. Does this work or not or just 
enough to see messages? I am dealing with the same exact thing for the 
3512 chipset.

Aron


-- 

ssh aron@rubinium.org cat /dev/brain | grep ^work:

Aron Rubin                       Member, Engineering Staff
Lockheed Martin                  E-Mail: arubin@atl.lmco.com
Advanced Technology Laboratories Phone:  856.792.9865
3 Executive Campus               Fax:    856.792.9930
Cherry Hill, NJ USA 08002        Web:    http://www.atl.lmco.com

