Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbUBWRr6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 12:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbUBWRr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 12:47:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42907 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261973AbUBWRr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 12:47:57 -0500
Date: Mon, 23 Feb 2004 09:47:52 -0800
From: "David S. Miller" <davem@redhat.com>
To: Mipam <mipam@ibb.net>
Cc: linux-kernel@vger.kernel.org, mipam@ibb.net
Subject: Re: broadcom bcm5703 support in 2.6.3?
Message-Id: <20040223094752.572ab884.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0402231043430.30027-100000@ux1.ibb.net>
References: <Pine.LNX.4.33.0402231043430.30027-100000@ux1.ibb.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Feb 2004 10:59:53 +0100 (MET)
Mipam <mipam@ibb.net> wrote:

> No where appears to be bcm5703 support.

The tigon3 driver supports the whole bcm57XX series gigabit chips.
The core chip in the 57XX series is code named "tigon3", the successor
to the Alteon Acenic tigon and tigon2 chips.
