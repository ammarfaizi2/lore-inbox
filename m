Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262948AbVCWVyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262948AbVCWVyv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 16:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262936AbVCWVyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 16:54:51 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:11452 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262950AbVCWVyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 16:54:44 -0500
Date: Wed, 23 Mar 2005 13:54:13 -0800
From: Mike kravetz <kravetz@us.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] ppc64: Add mem=X option, updated NUMA support
Message-ID: <20050323215413.GF3986@w-mikek2.ibm.com>
References: <200503232311.11113.michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503232311.11113.michael@ellerman.id.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2005 at 11:11:10PM +1100, Michael Ellerman wrote:
> 
> Can you test this on your 720 or whatever it was? And if anyone else
> has an interesting NUMA machine they can test it on I'd love to hear
> about it!
> 

I've tested this with various config options on my 720.  Appears to
work well on all that I tested.

-- 
Mike
