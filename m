Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWB0TwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWB0TwH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 14:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWB0TwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 14:52:07 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.7]:24082 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S932091AbWB0TwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 14:52:02 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Greg KH <greg@kroah.com>
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Date: Mon, 27 Feb 2006 19:52:08 +0000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, davej@redhat.com, perex@suse.cz,
       gregkh@suse.de, Kay Sievers <kay.sievers@vrfy.org>
References: <20060227190150.GA9121@kroah.com>
In-Reply-To: <20060227190150.GA9121@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602271952.08949.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 February 2006 19:01, Greg KH wrote:
[snip]
> +
> +Interfaces in the testing state can move to the stable state when the
> +developers feel they are finished.  They can not be removed from the
> +kernel tree without going through the obsolete state first.
> +
> +It's up to the developer to place their interface in the category they
> +wish for it to start out in.
> --- /dev/null
> +++ gregkh-2.6/Documentation/ABI/obsolete/devfs
> @@ -0,0 +1,13 @@
> +What:		devfs
> +Date:		July 2005
> +Contact:	Greg Kroah-Hartman <gregkh@suse.de>
[snip]

July 2005? Either this date is wrong or the document is out of date.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
