Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVDHWHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVDHWHB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 18:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVDHWHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 18:07:01 -0400
Received: from mail.kroah.org ([69.55.234.183]:23465 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261159AbVDHWG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 18:06:57 -0400
Date: Fri, 8 Apr 2005 15:06:09 -0700
From: Greg KH <greg@kroah.com>
To: blaisorblade@yahoo.it
Cc: stable@kernel.org, jdike@addtoit.com, linux-kernel@vger.kernel.org
Subject: Re: [stable] [patch 1/1] uml: quick fix syscall table [urgent]
Message-ID: <20050408220607.GB3399@kroah.com>
References: <20050406183802.48AF7C5D4E@zion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050406183802.48AF7C5D4E@zion>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2005 at 08:38:00PM +0200, blaisorblade@yahoo.it wrote:
> 
> CC: <stable@kernel.org>
> 
> I'm resending this for inclusion in the -stable tree. I've deleted whitespace
> cleanups, and hope this can be merged. I've been asked to split the former
> patch, I don't know if I must split again this one, even because I don't want
> to split this correct patch into multiple non-correct ones by mistake.

Thanks, I've added this to the stable queue.

greg k-h
