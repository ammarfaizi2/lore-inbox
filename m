Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbVJHTJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbVJHTJb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 15:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbVJHTJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 15:09:31 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:6446 "EHLO
	pd3mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751069AbVJHTJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 15:09:30 -0400
Date: Sat, 08 Oct 2005 13:09:13 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Anybody know about nforce4 SATA II hot swapping + linux raid?
In-reply-to: <4VnSe-hv-15@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43481959.2080807@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4UXuH-EU-31@gated-at.bofh.it> <4VhD6-79H-7@gated-at.bofh.it>
 <4VnSe-hv-15@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Molle Bestefich wrote:
> IDE hotswap has never worked (OOTB at least) in Linux, and based on my
> experience it never will.  Seems the IDE folks doesn't care a bit
> about it.  (No offence meant.  Just keeping it real.)

If you mean IDE as in PATA, it's not supported in the kernel because 
PATA hardware does not generally support hotswap, the controllers and 
drives are not designed for it.

SATA is very different in regards to hardware capabilities and kernel 
support for hotswap..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

