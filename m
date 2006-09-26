Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWIZRfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWIZRfS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 13:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWIZRfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 13:35:17 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:55689 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932174AbWIZRfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 13:35:16 -0400
Message-ID: <451964D2.4090203@pobox.com>
Date: Tue, 26 Sep 2006 13:35:14 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libata: tighten rules for legacy dependancies
References: <1159288642.11049.253.camel@localhost.localdomain>
In-Reply-To: <1159288642.11049.253.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> The legacy and QDI drivers are ISA/VLB bus [we don't have a VLB define
> but ISA will do nicely].
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied


