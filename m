Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWHWIfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWHWIfK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 04:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbWHWIfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 04:35:10 -0400
Received: from mail.gmx.de ([213.165.64.20]:60811 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964774AbWHWIfI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 04:35:08 -0400
X-Authenticated: #428038
Date: Wed, 23 Aug 2006 10:35:04 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org
Subject: Re: Linux 2.6.17.10
Message-ID: <20060823083504.GA31519@merlin.emma.line.org>
Mail-Followup-To: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org
References: <20060822192727.GA8579@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060822192727.GA8579@kroah.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.13 (2006-08-15)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Removing stable@ from Cc:)

Greg KH schrieb am 2006-08-22:

> Sridhar Samudrala:
>       Fix sctp privilege elevation (CVE-2006-3745)

I've seen gazillions of CVE numbers for SCTP over the past months.

Should perhaps SCTP be dropped from the kernel until it has been audited
for security by at least two independent parties?

-- 
Matthias Andree
