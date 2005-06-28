Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbVF1R0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVF1R0U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 13:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbVF1RXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 13:23:10 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:39264 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262166AbVF1RTY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 13:19:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jL1tZ4LEbTXbWr6Nq8nl61+lsbjLHnOZUtDVhEvwoMco8PcnwAjFhTlFhUEzQ2s34Swi21dhgvKHE0eU1vZGO7q9OtRkIbMtFphdmHzvcR4lNqPbQ1gheOUotlnq+1pvUicoSY8CnXC3ptXQ+FjT/IqSKoJk3eW7+K/jOK9y6cI=
Message-ID: <3afbacad05062810183bf640d2@mail.gmail.com>
Date: Tue, 28 Jun 2005 19:18:44 +0200
From: Jim MacBaine <jmacbaine@gmail.com>
Reply-To: Jim MacBaine <jmacbaine@gmail.com>
To: Chris Wright <chrisw@osdl.org>
Subject: Re: [stable] Re: [00/07] -stable review
Cc: stable@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050628144706.GX9046@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050627224651.GI9046@shell0.pdx.osdl.net>
	 <3afbacad050628051059b69bbe@mail.gmail.com>
	 <20050628144706.GX9046@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/05, Chris Wright <chrisw@osdl.org> wrote:

> I assume you're referring to this fix:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111936734211687&w=2
> 
> If so, I expect it will.  Needs to hit mainline first and get pushed over
> to -stable.
 
That's the one I'm referring to.  This patch works for me on 2.6.12.1.

Regards,
Jim
