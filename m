Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269912AbUJGXGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269912AbUJGXGX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 19:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269911AbUJGXAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 19:00:44 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:27304
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S268232AbUJGWtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:49:14 -0400
Date: Thu, 7 Oct 2004 15:48:06 -0700
From: "David S. Miller" <davem@davemloft.net>
To: <hzhong@cisco.com>
Cc: msipkema@sipkema-digital.com, cfriesen@nortelnetworks.com, jst1@email.com,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       davem@redhat.com
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-Id: <20041007154806.2b76f475.davem@davemloft.net>
In-Reply-To: <012001c4acbf$786766f0$b83147ab@amer.cisco.com>
References: <20041007152400.17e8f475.davem@davemloft.net>
	<012001c4acbf$786766f0$b83147ab@amer.cisco.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2004 15:46:23 -0700
"Hua Zhong" <hzhong@cisco.com> wrote:

> The reason is that you haven't just admitted very clearly that 
> "Linux select isn't Posix compliant and it was a design decision 
> not to do so for performance reasons".

It is, happy now? :-)

I never claimed it to be POSIX compliant.
