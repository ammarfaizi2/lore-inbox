Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbUBUEMq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 23:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbUBUEMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 23:12:46 -0500
Received: from terminus.zytor.com ([63.209.29.3]:29366 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261532AbUBUEMm
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 23:12:42 -0500
Message-ID: <4036DA90.2030709@zytor.com>
Date: Fri, 20 Feb 2004 20:12:00 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Coywolf Qi Hunt <coywolf@greatcn.org>
CC: Linux-Kernel@vger.kernel.org, tao@acc.umu.se, Riley@Williams.Name,
       davej@codemonkey.org.uk, alan@lxorguk.ukuu.org.uk,
       root@chaos.analogic.com, torvalds@osdl.org
Subject: Re: [2.0.40 2.2.25 2.4.25] Fix boot GDT limit 0x800 to 0x7ff in setup.S
 or not
References: <403114D9.2060402@lovecn.org> <40318FB0.6060109@lovecn.org> <4036D2EB.1090709@greatcn.org>
In-Reply-To: <4036D2EB.1090709@greatcn.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:
> 
> Please fix 0x8000 to 0x800 in 2.4, and 0x800 to 0x7ff in 2.0~2.4, ok?
> This is my last appeal.
> 

Submit a patch.

	-hpa
