Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759888AbWLEPAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759888AbWLEPAl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 10:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760127AbWLEPAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 10:00:41 -0500
Received: from rtr.ca ([64.26.128.89]:2205 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759846AbWLEPAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 10:00:40 -0500
Message-ID: <45758996.4080502@rtr.ca>
Date: Tue, 05 Dec 2006 10:00:38 -0500
From: Mark Lord <liml@rtr.ca>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: -mm merge plans for 2.6.20
References: <20061204204024.2401148d.akpm@osdl.org>	<4574FC0A.8090607@garzik.org> <20061204214114.433485fc.akpm@osdl.org>
In-Reply-To: <20061204214114.433485fc.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Mon, 04 Dec 2006 23:56:42 -0500
> Jeff Garzik <jeff@garzik.org> wrote:
> 
>> Andrew Morton wrote:
> 
>>> libata_resume_fix.patch
>> I thought this was resolved long ago?  Are there still open reports that 
>> this solves, where upstream doesn't work?
> 
> Heck, I don't know.

You probably pinched it from my website originally, and I nabbed it from
an LKML posting 18 months ago.  It's a patch that was required here back
in the 2.6.12 - 2.6.16 era, and it is no longer needed now.

Drop it.
