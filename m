Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268107AbUJMAMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268107AbUJMAMy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 20:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268108AbUJMAMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 20:12:54 -0400
Received: from smtp-out6.blueyonder.co.uk ([195.188.213.9]:61323 "EHLO
	smtp-out6.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S268107AbUJMAMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 20:12:49 -0400
Message-ID: <416C7112.4000609@blueyonder.co.uk>
Date: Wed, 13 Oct 2004 01:04:34 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.8 (X11/20040914)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mathieu Segaud <matt@minas-morgul.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1 Oops [2]
References: <416B9517.7010708@blueyonder.co.uk> <877jpwi8cg.fsf@barad-dur.crans.org>
In-Reply-To: <877jpwi8cg.fsf@barad-dur.crans.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 13 Oct 2004 00:05:01.0674 (UTC) FILETIME=[48E64CA0:01C4B0B8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Segaud wrote:
> Sid Boyce <sboyce@blueyonder.co.uk> disait dernièrement que :
> 
> 
>>This one on attempting to start firefox.
>>Regards
>>Sid.
> 
> 
> about the 2 reports you made about oopses, try this
> cd /path/to/your/kernel/source
> wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/nroken-out/optimize-profile-path-slightly.patch
> patch -R -p1 -i optimize-profile-path-slightly.patch
> 
> it should fix them
> 
> Regards,
> 
Thanks, that dixed it.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
=====LINUX ONLY USED HERE=====
