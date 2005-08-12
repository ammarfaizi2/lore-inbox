Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbVHLTEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbVHLTEg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 15:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbVHLTEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 15:04:36 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:47020 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751240AbVHLTEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 15:04:35 -0400
Subject: Re: rc6 keeps hanging and blanking displays where rc4-mm1 works
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Burgess <aab@cichlid.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200508121734.j7CHY9Bg001702@cichlid.com>
References: <200508121734.j7CHY9Bg001702@cichlid.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 12 Aug 2005 20:31:31 +0100
Message-Id: <1123875091.22460.77.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-08-12 at 10:34 -0700, Andrew Burgess wrote:
> >Unless you are using data=journal and have turned write cache off on
> >your IDE drives that is expected. 
> 
> I seem to recall reading that after a power failure a modern IDE drive gets
> enough power from the motor spinning down to always be able to write the cache
> to the media.

Urban legend.

