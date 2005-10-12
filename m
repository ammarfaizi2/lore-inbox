Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbVJLX4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbVJLX4e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 19:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbVJLX4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 19:56:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17338 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964811AbVJLX4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 19:56:33 -0400
Date: Wed, 12 Oct 2005 16:56:31 -0700
From: Chris Wright <chrisw@osdl.org>
To: "Gabriel A. Devenyi" <ace@staticwave.ca>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] nfsv4 in linux 2.6.13 (-ck7)
Message-ID: <20051012235630.GL5856@shell0.pdx.osdl.net>
References: <200510121903.04485.ace@staticwave.ca> <200510121927.22296.ace@staticwave.ca> <20051012233159.GJ5856@shell0.pdx.osdl.net> <200510121937.55434.ace@staticwave.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510121937.55434.ace@staticwave.ca>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Gabriel A. Devenyi (ace@staticwave.ca) wrote:

> Thanks, I'll keep that in mind for next time. With regards to the
> patch in the other thread, should I try and patch the client, the
> server or both?

Client side AFAIK.  May want to check with the nfs folks to see if
they've got any specific testing they'd find useful.

thanks,
-chris
