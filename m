Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263487AbTICOhE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 10:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263488AbTICOhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 10:37:04 -0400
Received: from inetc.connecttech.com ([64.7.140.42]:20240 "EHLO
	inetc.connecttech.com") by vger.kernel.org with ESMTP
	id S263487AbTICOhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 10:37:02 -0400
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: <root@chaos.analogic.com>, "'James Clark'" <jimwclark@ntlworld.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Driver Model
Date: Wed, 3 Sep 2003 10:36:16 -0400
Organization: Connect Tech Inc.
Message-ID: <002301c37228$bbc89950$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
In-Reply-To: <Pine.LNX.4.53.0309021620050.4709@chaos>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Richard B. Johnson
> sources are available. If the driver does not contain the appropriate
> MODULE_LICENSE() string, then several tools will show "tainted" so

If the MODULE_LICENSE() macro is what determines taint, what's to
prevent a company from compiling their driver in their own kernel tree
with that macro and releasing it binary-only? Wouldn't that module
then be taint-free?

..Stu

