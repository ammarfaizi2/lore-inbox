Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbWIMURr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbWIMURr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 16:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWIMURr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 16:17:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7651 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751041AbWIMURr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 16:17:47 -0400
Date: Wed, 13 Sep 2006 17:16:35 -0300
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
To: Alex Williamson <alex.williamson@hp.com>
Cc: rmk+serial@arm.linux.org.uk, linux-kernel <linux-kernel@vger.kernel.org>,
       akpm@osdl.org
Subject: Re: [PATCH] 8250 UART backup timer
Message-ID: <20060913201635.GA4787@cathedrallabs.org>
References: <1151435054.11285.41.camel@lappy> <1152070743.5710.20.camel@lappy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152070743.5710.20.camel@lappy>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,
>    Ping.  Any other comments on this?  Thanks,
this was tested on the following HP machines and solved the problem:
rx2600, rx2620, rx1600 and rx1620s

Russel, is there any objections on this patch[1]?

Otherwise,
Acked-by: Aristeu S. Rozanski F. <aris@cathedrallabs.org>

[1] http://lkml.org/lkml/2006/6/27/472

-- 
Aristeu

