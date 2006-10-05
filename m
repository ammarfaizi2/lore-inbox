Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751626AbWJEKxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbWJEKxU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 06:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbWJEKxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 06:53:19 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:8924 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751626AbWJEKxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 06:53:19 -0400
Message-ID: <4524E41C.70701@pobox.com>
Date: Thu, 05 Oct 2006 06:53:16 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libata: Winbond support
References: <1159551005.13029.46.camel@localhost.localdomain>
In-Reply-To: <1159551005.13029.46.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Winbond 83759A support in non-multichip mode (afaik nobody ever used
> multichip mode anyway). The 83759 is not supported by this driver as it
> is already handled elsewhere and doens't use the same interfaces.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied to #upstream, but you need to quit adding trailing whitespace :)


