Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbVBIIrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVBIIrE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 03:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbVBIIrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 03:47:04 -0500
Received: from postfix4-1.free.fr ([213.228.0.62]:40067 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S261727AbVBIIrC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 03:47:02 -0500
Subject: Re: Touchpad problems with 2.6.11-rc2
From: Stephane Raimbault <stephane.raimbault@free.fr>
To: Peter Osterlund <petero2@telia.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <m3oeev3rt7.fsf@telia.com>
References: <1107860158.5271.12.camel@picasso.lan>
	 <m3oeev3rt7.fsf@telia.com>
Content-Type: text/plain
Date: Wed, 09 Feb 2005 09:47:37 +0100
Message-Id: <1107938857.4456.3.camel@picasso.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Does the "Enable hardware tapping for ALPS touchpads" patch help?
> 
>         http://marc.theaimsgroup.com/?l=linux-kernel&m=110708138225873&w=2
> 

Yes, works really better but the release event is sent only if I move
the pointer. It's as if I still put my finger on the touchpad.

Stephane



