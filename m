Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264922AbTLKToe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 14:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265056AbTLKToe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 14:44:34 -0500
Received: from holomorphy.com ([199.26.172.102]:60134 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264922AbTLKTod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 14:44:33 -0500
Date: Thu, 11 Dec 2003 11:44:30 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where did the ELF spec go?  (SCO website?)
Message-ID: <20031211194430.GL8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org
References: <C033B4C3E96AF74A89582654DEC664DB0672F1@aruba.maner.org> <20031211094148.G28449@links.magenta.com> <20031211150011.GF8039@holomorphy.com> <200312111326.32483.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312111326.32483.rob@landley.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 December 2003 09:00, William Lee Irwin III wrote:
>> You have it backward. The SVR4/i386 ELF ABI specification is requiring
>> userspace to be granted at least 3GB of address space.

On Thu, Dec 11, 2003 at 01:26:32PM -0600, Rob Landley wrote:
> Where does one get a copy of the SVR4 spec these days?  The link I
> could track down went to http://www.sco.com/developer/devspecs/ which
> just ain't there no more.
> And no, not because of a "DDOS".  There isn't one.  SCO's website IP moved 
> from 216.250.128.13 to 216.250.128.20, and it's up at the new IP right now.  
> They didn't get the new DNS record propogated on time.  Rookie mistake...
> But looking at http.://216.250.128.20/developer/devspecs redirects
> you to the /developer page.  The devspecs page went away...
> Is this mirrored somewhere?

I'm looking at a dead tree copy. I have no idea if it's online or not.

Also, it's largely an ELF ABI spec; I'm not sure how/why SVR4 got into
the picture, but its name is on there.


-- wli
