Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261935AbVAaGOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbVAaGOr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 01:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbVAaGOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 01:14:46 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:23006
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261935AbVAaGON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 01:14:13 -0500
Date: Sun, 30 Jan 2005 22:08:34 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: recent 2.6.x USB HID input weirdness
Message-Id: <20050130220834.6d5279db.davem@davemloft.net>
In-Reply-To: <1107150754.7801.8.camel@pegasus>
References: <20050130212739.060f8e6f.davem@davemloft.net>
	<1107150754.7801.8.camel@pegasus>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2005 06:52:34 +0100
Marcel Holtmann <marcel@holtmann.org> wrote:

> take a look at this patch: http://lkml.org/lkml/2005/1/29/111

That certainly fixes it, thanks :-)
