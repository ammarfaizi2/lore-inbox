Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262032AbUKKJXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbUKKJXP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 04:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbUKKJXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 04:23:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:5038 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262032AbUKKJXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 04:23:13 -0500
Date: Thu, 11 Nov 2004 01:23:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: ilia.sotnikov@asstra.by
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IPSec: cleartext packets path for 2.6.9
Message-Id: <20041111012301.4a438d0f.akpm@osdl.org>
In-Reply-To: <OF04E350FB.B5E6A355-ONC2256F49.002E41FB-85256F49.00549F7C@asstra.by>
References: <OF04E350FB.B5E6A355-ONC2256F49.002E41FB-85256F49.00549F7C@asstra.by>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ilia.sotnikov@asstra.by wrote:
>
> IPSec: 
>  Let incoming packets after decapsulation in transport mode traverse the 
>  same 
>  path as with tunnels. 

Your patch is hopelessly wordwrapped.  Please fix your email client then
send the patch to yourself and test it.  Once all that works, be sure to
cc netdev@oss.sgi.com when you resend.  
