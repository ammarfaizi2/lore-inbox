Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262228AbVCISl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbVCISl6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 13:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbVCISln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 13:41:43 -0500
Received: from mail.kroah.org ([69.55.234.183]:42945 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262228AbVCISi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 13:38:29 -0500
Date: Wed, 9 Mar 2005 10:38:16 -0800
From: Greg KH <greg@kroah.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, chrisw@osdl.org, torvalds@osdl.org,
       akpm@osdl.org
Subject: Re: Linux 2.6.11.2
Message-ID: <20050309183816.GC26902@kroah.com>
References: <20050309083923.GA20461@kroah.com> <20050309140359.GB15110@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050309140359.GB15110@logos.cnet>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 11:03:59AM -0300, Marcelo Tosatti wrote:
> 
> Hi Greg,
> 
> The st/ide-tape/osst llseek changes havent been applied for what reason? 
> 
> And what about the rest of fixups which Andrew sent you? 
> 
> I suppose they didnt pass the -stable criteria. Can you share your thoughts 
> with the rest of us?

They are in the -stable queue, and should go our for review later today,
and will attempt to follow the proposed proceedure.

I didn't add them to .2 as that was released just due to the security
update.

thanks,

greg k-h
