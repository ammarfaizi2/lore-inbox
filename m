Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269911AbUJGXGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269911AbUJGXGY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 19:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269910AbUJGXAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 19:00:38 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:24744
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269891AbUJGWsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:48:41 -0400
Date: Thu, 7 Oct 2004 15:47:22 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: msipkema@sipkema-digital.com, cfriesen@nortelnetworks.com,
       hzhong@cisco.com, jst1@email.com, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, davem@redhat.com
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-Id: <20041007154722.2a09c4ab.davem@davemloft.net>
In-Reply-To: <20041007224242.GA31430@mark.mielke.cc>
References: <00e501c4ac9a$556797d0$b83147ab@amer.cisco.com>
	<41658C03.6000503@nortelnetworks.com>
	<015f01c4acbe$cf70dae0$161b14ac@boromir>
	<4165B9DD.7010603@nortelnetworks.com>
	<20041007150035.6e9f0e09.davem@davemloft.net>
	<000901c4acc4$26404450$161b14ac@boromir>
	<20041007152400.17e8f475.davem@davemloft.net>
	<20041007224242.GA31430@mark.mielke.cc>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2004 18:42:42 -0400
Mark Mielke <mark@mark.mielke.cc> wrote:

> Sure, it's nice to demand that people
> upgrade to a later version of Perl. Guess what? It isn't happening. It
> will be another year or two before we can guarantee people have Perl
> 5.006 on their system.

If those people are tepid about upgrading perl, I think it would
be even less likely that they would upgrade their kernels.
