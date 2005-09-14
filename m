Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbVINVIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbVINVIt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 17:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932758AbVINVIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 17:08:49 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17678 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932459AbVINVIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 17:08:48 -0400
Date: Wed, 14 Sep 2005 22:08:37 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alexey Dobriyan <adobriyan@gmail.com>, spyro@f2s.com
Cc: Andrew Morton <akpm@osdl.org>, Domen Puncer <domen@coderock.org>,
       linux-kernel@vger.kernel.org, Phil Blundell <philb@gnu.org>
Subject: Re: [PATCH] Remove drivers/parport/parport_arc.c
Message-ID: <20050914220837.D30746@flint.arm.linux.org.uk>
Mail-Followup-To: Alexey Dobriyan <adobriyan@gmail.com>, spyro@f2s.com,
	Andrew Morton <akpm@osdl.org>, Domen Puncer <domen@coderock.org>,
	linux-kernel@vger.kernel.org, Phil Blundell <philb@gnu.org>
References: <20050914202420.GK19491@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050914202420.GK19491@mipter.zuzino.mipt.ru>; from adobriyan@gmail.com on Thu, Sep 15, 2005 at 12:24:20AM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 12:24:20AM +0400, Alexey Dobriyan wrote:
> From: Domen Puncer <domen@coderock.org>
> 
> Remove nowhere referenced file (grep "parport_arc\." didn't find anything).

Maybe Ian Molton might like to ensure that this is linked in to the
build.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
