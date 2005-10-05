Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965102AbVJEKJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965102AbVJEKJw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 06:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965103AbVJEKJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 06:09:51 -0400
Received: from free.hands.com ([83.142.228.128]:31907 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S965102AbVJEKJv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 06:09:51 -0400
Date: Wed, 5 Oct 2005 11:09:42 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: "D. Hazelton" <dhazelton@enter.net>
Cc: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051005100942.GN10538@lkcl.net>
References: <20051002204703.GG6290@lkcl.net> <4342DC4D.8090908@perkel.com> <200510050122.39307.dhazelton@enter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510050122.39307.dhazelton@enter.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 01:22:33AM +0000, D. Hazelton wrote:
> On Tuesday 04 October 2005 19:47, Marc Perkel wrote:

> As someone else pointed out, this is because unlinking is related to 
> your access permissions on the parent directory and not the file.
 
 that's POSIX.

 i trust that POSIX has not been hard-coded into the entire design of
 the linux kernel filesystem architecture _just_ because it's ... POSIX.

 l.

