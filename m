Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbVKIQ7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbVKIQ7q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 11:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbVKIQ7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 11:59:46 -0500
Received: from mail.dvmed.net ([216.237.124.58]:65507 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932153AbVKIQ7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 11:59:45 -0500
Message-ID: <43722AFC.4040709@pobox.com>
Date: Wed, 09 Nov 2005 11:59:40 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Beulich <JBeulich@novell.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/39] NLKD - Novell Linux Kernel Debugger
References: <43720DAE.76F0.0078.0@novell.com>
In-Reply-To: <43720DAE.76F0.0078.0@novell.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Beulich wrote:
> The following patch set represents the Novell Linux Kernel Debugger,
> stripped off of its original low-level exception handling framework.


Honestly, just seeing all these code changes makes me think we really 
don't need it in the kernel.  How many "early" and "alternative" gadgets 
do we really need just for this thing?

	Jeff


