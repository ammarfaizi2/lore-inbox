Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264206AbUD0R2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264206AbUD0R2D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 13:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264211AbUD0R2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 13:28:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58595 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264206AbUD0R2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 13:28:00 -0400
Date: Tue, 27 Apr 2004 10:26:35 -0700
From: "David S. Miller" <davem@redhat.com>
To: Michal Ludvig <mludvig@suse.cz>
Cc: jmorris@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto_null autoload
Message-Id: <20040427102635.6168b783.davem@redhat.com>
In-Reply-To: <408E53E8.50305@suse.cz>
References: <Xine.LNX.4.44.0404231005130.26066-100000@thoron.boston.redhat.com>
	<408E53E8.50305@suse.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2004 14:36:56 +0200
Michal Ludvig <mludvig@suse.cz> wrote:

> > It would be nice to also have these for:
> > 
> > alias des3_ede des
> > alias sha384 sha512
> 
> Attached.

Applied, thanks.
