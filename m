Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272231AbTG2VXx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 17:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272069AbTG2VVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 17:21:30 -0400
Received: from [64.105.205.123] ([64.105.205.123]:33106 "HELO borg.org")
	by vger.kernel.org with SMTP id S272382AbTG2VUh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 17:20:37 -0400
Date: Tue, 29 Jul 2003 17:20:35 -0400
From: Kent Borg <kentborg@borg.org>
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org, pgw99@doc.ic.ac.uk
Subject: Re: PATCH : LEDs - possibly the most pointless kernel subsystem ever
Message-ID: <20030729172035.D6570@borg.org>
References: <200307291915.h6TJF6YB000421@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200307291915.h6TJF6YB000421@81-2-122-30.bradfords.org.uk>; from john@grabjohn.com on Tue, Jul 29, 2003 at 08:15:06PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 29, 2003 at 08:15:06PM +0100, John Bradford wrote:
> Does anybody have any suggestions for recommended standard uses for
> parallel port connected LEDs?

I think someone else mentioned notification of e-mail.  Well, I get
too much e-mail for that (I am on the kernel list, after all) but that
suggestion make me think of a soft of "Check Engine" light.

In my Red Hat box there are various sanity checks that happen
regularly and they send me an e-mail when one of those items goes
wrong.  For example, if a raid disk dies or a partition gets too full
(what are others?), I get an e-mail.  It might be nice to have those
programs also light an LED.


-kb
