Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbTJWCnm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 22:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbTJWCnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 22:43:42 -0400
Received: from ms-smtp-01.rdc-kc.rr.com ([24.94.166.115]:35979 "EHLO
	ms-smtp-01.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S261580AbTJWCnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 22:43:40 -0400
Date: Wed, 22 Oct 2003 21:43:09 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test7 usbserial oops
Message-ID: <20031023024309.GA6421@glitch.localdomain>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
References: <20030911033054.GA1375@glitch.localdomain> <20031011193558.GA1404@glitch.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031011193558.GA1404@glitch.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 11, 2003 at 02:35:59PM -0500, Greg Norris wrote:
> In case anyone was wondering, this problem still occurs with
> 2.6.0-test7.  I've attached all the relevant information which I'm
> aware of, and would be happy to provide additional details/testing if
> requested.  Suggestions would, of course, be quite welcome.

I just received my new Treo 600 yesterday, and I'm happy to report that
it has no problem syncing under the 2.6.0-test8 kernel.  The Treo 300,
on the other hand, still triggers the oops with 100% reliability.  I
expect to have access to the 300 for some time, so I'd be happy to
verify any fixes which are developed.
