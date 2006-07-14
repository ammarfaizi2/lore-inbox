Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945921AbWGNX4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945921AbWGNX4U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 19:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945923AbWGNX4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 19:56:19 -0400
Received: from pih-relay04.plus.net ([212.159.14.131]:33761 "EHLO
	pih-relay04.plus.net") by vger.kernel.org with ESMTP
	id S1945921AbWGNX4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 19:56:19 -0400
Message-ID: <44B82F18.5040705@adslpipe.co.uk>
Date: Sat, 15 Jul 2006 00:56:08 +0100
From: Andy Burns <fedora@adslpipe.co.uk>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: strange kobject messages in .18rc1git3
References: <20060712041642.GG32707@redhat.com> <20060713212201.GB4218@kroah.com>
In-Reply-To: <20060713212201.GB4218@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> Dave Jones wrote:
>>
>> kobject_add failed for vcs63 with -EEXIST, don't try to register things with the
>> same name in the same directory.
> 
> Does the machine work properly after this message?

yes, resumes ok and runs with no apparent problems


