Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263434AbTECVnj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 17:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263436AbTECVnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 17:43:39 -0400
Received: from lakemtao03.cox.net ([68.1.17.242]:47273 "EHLO
	lakemtao03.cox.net") by vger.kernel.org with ESMTP id S263434AbTECVni
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 17:43:38 -0400
Message-ID: <3EB43ADC.3050306@cox.net>
Date: Sat, 03 May 2003 16:55:40 -0500
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Florian Zimmermann <florian.zimmermann@gmx.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: USB mouse not working with 2.5.66+
References: <1051990656.868.7.camel@mindfuck.cjb.net>
In-Reply-To: <1051990656.868.7.camel@mindfuck.cjb.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Zimmermann wrote:
> I don't get my logitech USB mouse work with 2.5.66 or 2.5.68.
> kernel messages tell "bulk timeout" messages on booting.
> With 2.4.[19,20] the mouse works fine.
> 
> What can I do to make it work??

Disable ACPI.. That worked for me. If you aren't using ACPI, then I 
don't know.

Regards,
David

