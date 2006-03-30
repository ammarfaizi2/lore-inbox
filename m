Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWC3Abt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWC3Abt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 19:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbWC3Abt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 19:31:49 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:50157 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751301AbWC3Abi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 19:31:38 -0500
Message-ID: <442B26E8.6060300@pobox.com>
Date: Wed, 29 Mar 2006 19:31:36 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: PATCH: Fix interesting use of "extern" and also some bracketing
References: <1143482492.4970.69.camel@localhost.localdomain>
In-Reply-To: <1143482492.4970.69.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.6 (---)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-3.6 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> Last of the set, just clean up some oddments. Assuming the whole set is
> now ok then the remaining differences are the setup of PIO_0 at reset
> and the ->data_xfer method.

applied


