Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262603AbVAKA2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbVAKA2J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 19:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbVAKA2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 19:28:09 -0500
Received: from orb.pobox.com ([207.8.226.5]:33191 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262603AbVAKATF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 19:19:05 -0500
Date: Mon, 10 Jan 2005 16:19:01 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Diego Calleja <diegocg@gmail.com>
Cc: Steve Bergman <steve@rueb.com>, linux-kernel@vger.kernel.org
Subject: Re: Proper procedure for reporting possible security vulnerabilities?
Message-ID: <20050111001901.GA4378@ip68-4-98-123.oc.oc.cox.net>
References: <41E2B181.3060009@rueb.com> <87d5wdhsxo.fsf@deneb.enyo.de> <41E2F6B3.9060008@rueb.com> <20050110230827.4d13ae7b.diegocg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050110230827.4d13ae7b.diegocg@gmail.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 11:08:27PM +0100, Diego Calleja wrote:
> They could have mailed to *THIS* mailing list, so anyone can make a patch.

And abandon the whole idea of coordinated disclosure? That would put
anyone using vendor kernels at a disadvantage (there would be a time gap
between the vulnerability being public and the vendor kernel being
released -- which happened anyway with uselib() but which doesn't
*always* happen).

-Barry K. Nathan <barryn@pobox.com>
