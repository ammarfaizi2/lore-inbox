Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWDAVS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWDAVS7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 16:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWDAVS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 16:18:59 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:13516 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932262AbWDAVS6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 16:18:58 -0500
Subject: Re: Remove unused exports and save 98Kb of kernel size
From: Marcel Holtmann <marcel@holtmann.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1143925545.3076.35.camel@laptopd505.fenrus.org>
References: <1143925545.3076.35.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Sat, 01 Apr 2006 23:18:58 +0200
Message-Id: <1143926338.18439.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arjan,

> I've made a patch to remove all EXPORT_SYMBOL's that aren't used in the
> kernel; it's too big for the list so it can be found at
> 
> http://www.kernelmorons.org/unexport.patch

no ack for net/bluetooth/ from me.

Regards

Marcel


