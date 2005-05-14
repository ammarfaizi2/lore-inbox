Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262678AbVENBvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262678AbVENBvb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 21:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbVENBvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 21:51:31 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:60172 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S262675AbVENBva
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 21:51:30 -0400
Message-ID: <428559A4.1060300@rtr.ca>
Date: Fri, 13 May 2005 21:51:32 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050420 Debian/1.7.7-2
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Benjamin LaHaise <bcrl@kvack.org>, linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [rfc/patch] libata -- port configurable delays
References: <20050513185850.GA5777@kvack.org> <4284FC6E.7060300@pobox.com>
In-Reply-To: <4284FC6E.7060300@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PIIX chips should be fine w.r.t. unnecessary delays (or lack thereof).

I recall only one situation WAY BACK in time that had an issue with
continuous banging, but don't remember anything of the details
other than that this was circa 1995 or so.

Cheers
