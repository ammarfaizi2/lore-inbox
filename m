Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbVKVNPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbVKVNPf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 08:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbVKVNPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 08:15:35 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:10588 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751305AbVKVNPf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 08:15:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pYwUXJ2qQvajS3zkbaPtVdMXwkAc+Oq7P5TFucDNahpBQ7bDfxsjL69EEndtI6D4ngPncSmR7RW4vdNUQ/jPN4jCu7FQMb6W9kIGikAnfhLRCjAd1QaL5QoWQThy+WEFltvc0K6KigO0RzcKbWA/nRVmI0++bn7tconb+r1VdQs=
Message-ID: <84144f020511220515y375b85eck42d52af7ced52e84@mail.gmail.com>
Date: Tue, 22 Nov 2005 15:15:33 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: gmishkin@bu.edu
Subject: Re: 2.6.14.2 kernel oops, looks acpi-related
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
In-Reply-To: <200511220809.57038.gmishkin@acs.bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200511212050.10671.gmishkin@acs.bu.edu>
	 <20051122072830.GB25419@kroah.com>
	 <200511220809.57038.gmishkin@acs.bu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/05, Geoff Mishkin <gmishkin@acs.bu.edu> wrote:
> Alright, I can do that.  What about cisco_ipsec and fglrx?  cisco_ipsec I
> could live without, but fglrx would be difficult.  I've never been able to
> get the radeon driver working on my system, at all.

Please reproduce it without any binary-only drivers loaded.

                          Pekka
