Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751022AbWCBUBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbWCBUBD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 15:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWCBUBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 15:01:03 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:60073 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1751022AbWCBUBC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 15:01:02 -0500
Message-ID: <44074EF3.2020707@vilain.net>
Date: Fri, 03 Mar 2006 09:00:51 +1300
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Vilain <sam@vilain.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [Fwd: [PATCH 3/5] NFS: Abstract out namespace initialisation
 [try #2]]
References: <440613FF.4040807@vilain.net>
In-Reply-To: <440613FF.4040807@vilain.net>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain wrote:
> The attached patch abstracts out the namespace initialisation so that 
> temporary namespaces can be set up elsewhere.
> 
> Signed-Off-By: David Howells <dhowells@redhat.com>
> Acked-By: Sam Vilain <sam.vilain@catalyst.net.nz>

Sorry, folks, forgot the From: line in my Acks.  These patches are 
David's work, not mine :)

Sam.
