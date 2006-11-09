Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424216AbWKIWpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424216AbWKIWpu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 17:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424217AbWKIWpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 17:45:50 -0500
Received: from terminus.zytor.com ([192.83.249.54]:9166 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1424216AbWKIWps
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 17:45:48 -0500
Message-ID: <4553AF8E.60605@zytor.com>
Date: Thu, 09 Nov 2006 14:45:34 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: linux-kernel@vger.kernel.org, Henne Vogelsang <hvogel@suse.de>,
       Olaf Hering <olh@suse.de>
Subject: Re: util-linux: orphan
References: <20061109224157.GH4324@petra.dvoda.cz>
In-Reply-To: <20061109224157.GH4324@petra.dvoda.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karel Zak wrote:
> 
>  I've originally thought about util-linux upstream fork, but as
>  usually an fork is bad step. So.. I'd like to start some discussion
>  before this step. Maybe Adrian will be realistic and he will leave
>  the project and invest all his time to kernel only.
> 

Actually, forking is not really that bad of an idea.  When I took over 
tftp, for example, I just did it and called it tftp-hpa.  It didn't take 
very long before I got a message from the netkit maintainer asking if I 
was planning to continue, and if so if he could drop tftp from netkit.

A similar thing happened when Jeremy (and now Ian) took over autofs from me.

Forking gets your new maintainership proven *before* you end up taking 
over.  On the other hand, magicfilter effectively died when I handed it 
over to someone who didn't do a good job with it.

	-hpa
