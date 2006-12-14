Return-Path: <linux-kernel-owner+w=401wt.eu-S932784AbWLNUbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932784AbWLNUbd (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 15:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932790AbWLNUbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 15:31:33 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:49256 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932784AbWLNUbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 15:31:32 -0500
Message-ID: <4581B4A2.8070006@garzik.org>
Date: Thu, 14 Dec 2006 15:31:30 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: andersen@codepoet.org, Jeff Garzik <jeff@garzik.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] support HDIO_GET_IDENTITY in libata
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org> <200612141930.19797.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0612141150480.5718@woody.osdl.org> <4581AEA0.3040708@garzik.org> <20061214202608.GA2313@codepoet.org>
In-Reply-To: <20061214202608.GA2313@codepoet.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:
> +			if (!atapi_enabled && dev->class == ATA_DEV_ATAPI) {

This seems like an impossible condition?

	Jeff


