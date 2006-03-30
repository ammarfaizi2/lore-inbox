Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWC3AbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWC3AbN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 19:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWC3AbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 19:31:12 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:44525 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751299AbWC3AbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 19:31:11 -0500
Message-ID: <442B26CE.8020401@pobox.com>
Date: Wed, 29 Mar 2006 19:31:10 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: PATCH: Add ->set_mode hook for odd drivers
References: <1143481597.4970.52.camel@localhost.localdomain>
In-Reply-To: <1143481597.4970.52.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.6 (---)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-3.6 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Some hardware doesn't want the usual mode setup logic running. This
> allows the hardware driver to replace it for special cases in the least
> invasive way possible.
> 
> Signed-off-by: Alan Cox <alan@redhat.com> (and the previous diff)

applied


