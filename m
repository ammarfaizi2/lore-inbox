Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbVHLReN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbVHLReN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 13:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbVHLReN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 13:34:13 -0400
Received: from dsl3-63-249-67-204.cruzio.com ([63.249.67.204]:53126 "EHLO
	cichlid.com") by vger.kernel.org with ESMTP id S1750751AbVHLReM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 13:34:12 -0400
Date: Fri, 12 Aug 2005 10:34:09 -0700
From: Andrew Burgess <aab@cichlid.com>
Message-Id: <200508121734.j7CHY9Bg001702@cichlid.com>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: rc6 keeps hanging and blanking displays where rc4-mm1 works
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Unless you are using data=journal and have turned write cache off on
>your IDE drives that is expected. 

I seem to recall reading that after a power failure a modern IDE drive gets
enough power from the motor spinning down to always be able to write the cache
to the media.

Am I wrong about that or do you mean something else?

