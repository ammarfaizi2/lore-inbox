Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265051AbUELNyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbUELNyD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 09:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265094AbUELNyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 09:54:03 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:20616 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S265051AbUELNyB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 09:54:01 -0400
Subject: Re: [PATCH 2.6.6-mm1] bluetooth definition redundancy fix
From: Marcel Holtmann <marcel@holtmann.org>
To: FabF <Fabian.Frederick@skynet.be>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1084381970.7894.4.camel@bluerhyme.real3>
References: <1084381970.7894.4.camel@bluerhyme.real3>
Content-Type: text/plain
Message-Id: <1084370028.25099.60.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 12 May 2004 15:53:48 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabian,

> 	HCI Core debug context is redefined 4 times in mm1 bluetooth
> module.Here's a trivial patch to have it in hci_core.h (only).

this posting is on the wrong mailing list. Send such requests to the
BlueZ developer mailing list and not the LKML. However I am not going to
apply it, because everything is fine as it is.

Regards

Marcel


