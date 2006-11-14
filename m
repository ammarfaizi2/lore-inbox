Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965896AbWKNOwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965896AbWKNOwd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 09:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965886AbWKNOwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 09:52:33 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:32958 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965899AbWKNOwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 09:52:32 -0500
Message-ID: <4559D82D.8010608@pobox.com>
Date: Tue, 14 Nov 2006 09:52:29 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hpt37x: Check the enablebits
References: <1163002706.23956.33.camel@localhost.localdomain>
In-Reply-To: <1163002706.23956.33.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Helps for PATA but SATA bridged devices lie and always set all the bits
> so will need the error handling fixes from Tejun.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied


