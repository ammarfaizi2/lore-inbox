Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbUA3Unz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 15:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbUA3Unz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 15:43:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:31934 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262360AbUA3Uny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 15:43:54 -0500
Date: Fri, 30 Jan 2004 12:43:48 -0800
From: "David S. Miller" <davem@redhat.com>
To: Patrick Caulfield <patrick@tykepenguin.com>
Cc: linux-kernel@vger.kernel.org, Steve@ChyGwyn.com
Subject: Re: [PATCH] 1/2 DECnet fix SDF_WILD
Message-Id: <20040130124348.40c5c014.davem@redhat.com>
In-Reply-To: <20040126113106.GB21366@tykepenguin.com>
References: <20040126113106.GB21366@tykepenguin.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jan 2004 11:31:06 +0000
Patrick Caulfield <patrick@tykepenguin.com> wrote:

> This patch fixes the operation of SDF_WILD sockets on Linux 2.6.0/1
> (they don't currently work at all).

Please resubmit your patches as attachments or somehow otherwise
teach your email client not to turn tabs into spaces as this corrupts
your patches.

Thanks.
