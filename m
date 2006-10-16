Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751503AbWJPK5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbWJPK5S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 06:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWJPK5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 06:57:18 -0400
Received: from linux.dunaweb.hu ([62.77.196.1]:59817 "EHLO linux.dunaweb.hu")
	by vger.kernel.org with ESMTP id S1751503AbWJPK5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 06:57:17 -0400
Message-ID: <4533658A.5030105@dunaweb.hu>
Date: Mon, 16 Oct 2006 12:57:14 +0200
From: Zoltan Boszormenyi <zboszor@dunaweb.hu>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Prakash Punnoor <prakash@punnoor.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is there a way to limit VFAT allocation?
References: <4533598A.3040909@dunaweb.hu> <200610161225.33190.prakash@punnoor.de>
In-Reply-To: <200610161225.33190.prakash@punnoor.de>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash Punnoor írta:
> Am Montag 16 Oktober 2006 12:06 schrieb Zoltan Boszormenyi:
>   
>> Is there a way to tell the VFAT driver to exclude
>> the last N sectors from the allocation strategy?
>>     
>
> Can't you mark that clusters as bad with a diskeditor?
>   

Can you suggest one that works on Linux?
Or which bits should I change if I use LDE?
(lde.sourceforge.net)
