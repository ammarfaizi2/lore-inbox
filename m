Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264718AbUDVWLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264718AbUDVWLr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 18:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264719AbUDVWLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 18:11:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26755 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264718AbUDVWLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 18:11:45 -0400
Date: Thu, 22 Apr 2004 15:10:11 -0700
From: "David S. Miller" <davem@redhat.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: jmorris@redhat.com, jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: Large inlines in include/linux/skbuff.h
Message-Id: <20040422151011.4afa3ae2.davem@redhat.com>
In-Reply-To: <200404222239.34760.vda@port.imtp.ilyichevsk.odessa.ua>
References: <Xine.LNX.4.44.0404212046490.20483-100000@thoron.boston.redhat.com>
	<200404221756.46240.vda@port.imtp.ilyichevsk.odessa.ua>
	<20040422113645.19208a70.davem@redhat.com>
	<200404222239.34760.vda@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2004 22:39:34 +0300
Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:

> Okay. I am willing do it. Hmm...
> Which type of test will highlight the difference?
> I don't have gigabit network to play with. Any hints of how can I measure
> it on 100mbit?

Get someone to run specweb before and after your changes.
