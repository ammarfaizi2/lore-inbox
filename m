Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVANRzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVANRzg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 12:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVANRzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 12:55:36 -0500
Received: from orb.pobox.com ([207.8.226.5]:43992 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261242AbVANRzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 12:55:33 -0500
Date: Fri, 14 Jan 2005 09:55:27 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Dave Jones <davej@redhat.com>, "Barry K. Nathan" <barryn@pobox.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-mm1
Message-ID: <20050114175527.GA4745@ip68-4-98-123.oc.oc.cox.net>
References: <20050114002352.5a038710.akpm@osdl.org> <20050114150714.GA4501@ip68-4-98-123.oc.oc.cox.net> <20050114165612.GB19208@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050114165612.GB19208@redhat.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 11:56:12AM -0500, Dave Jones wrote:
> For *some* users. It still affects others.
> My Compaq Evo showed the bug with 2.6.9 vanilla, went away with 2.6.10
> vanilla.

Ok, I didn't know that.

Anyway, I've dug a bit deeper into my particular case, and there's now
some more information here:
http://bugme.osdl.org/show_bug.cgi?id=4041

-Barry K. Nathan <barryn@pobox.com>
