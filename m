Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262264AbSJBR5A>; Wed, 2 Oct 2002 13:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262275AbSJBR47>; Wed, 2 Oct 2002 13:56:59 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:39950 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S262264AbSJBR47>; Wed, 2 Oct 2002 13:56:59 -0400
Date: Wed, 2 Oct 2002 20:02:26 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Serverworks IDE driver broken in 2.5.40
Message-ID: <20021002180226.GA13140@louise.pinerecords.com>
References: <3D9B3AE1.2000902@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D9B3AE1.2000902@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With the driver built-in, the drives are not recognised. Built as a 
> module, it crashes on loading.
> 
> However I can see everything fine with the generic IDE driver
> 
> Works fine in 2.4.19+

Erm.  You actually meant to say works fine in 2.4.19+ *on certain
chipsets.*

T.
