Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269288AbUIHSaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269288AbUIHSaQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 14:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269289AbUIHSaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 14:30:16 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:41672
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269288AbUIHS3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 14:29:54 -0400
Date: Wed, 8 Sep 2004 11:26:48 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Gabriel Paubert <paubert@iram.es>
Cc: zach@vmware.com, linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
       hpa@zytor.com, bgerst@didntduck.org, Riley@Williams.Name
Subject: Re: PROBLEM: x86 alignment check bug
Message-Id: <20040908112648.4b4bc184.davem@davemloft.net>
In-Reply-To: <20040908121236.GA5283@iram.es>
References: <413E498D.4020807@vmware.com>
	<20040907170807.2e8bba1d.davem@davemloft.net>
	<20040908121236.GA5283@iram.es>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Sep 2004 14:12:36 +0200
Gabriel Paubert <paubert@iram.es> wrote:

> On Tue, Sep 07, 2004 at 05:08:07PM -0700, David S. Miller wrote:

I said:

> > While it is more difficult to disassemble x86 opcodes,

Then you said:

> I somehow suspect that Sparc is somewhat simpler to decode
> than i386/x86_64 ;-)

Thanks for agreeing with me! :-)
