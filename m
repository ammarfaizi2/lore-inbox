Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264748AbTFLMfw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 08:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264751AbTFLMfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 08:35:52 -0400
Received: from smtp-out.comcast.net ([24.153.64.115]:24690 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S264748AbTFLMfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 08:35:51 -0400
Date: Thu, 12 Jun 2003 08:49:32 -0400
From: Matt Reppert <repp0017@tc.umn.edu>
Subject: Re: SMP question
In-reply-to: <200306120837.40421.artemio@artemio.net>
To: Artemio <artemio@artemio.net>
Cc: linux-kernel@vger.kernel.org
Message-id: <20030612084932.437a010c.repp0017@tc.umn.edu>
Organization: Arashi no Kaze
MIME-version: 1.0
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <MDEHLPKNGKAHNMBLJOLKMEJLDJAA.davids@webmaster.com>
 <200306112313.30903.artemio@artemio.net>
 <20030611225401.GE2712@werewolf.able.es>
 <200306120837.40421.artemio@artemio.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jun 2003 08:37:40 +0300
Artemio <artemio@artemio.net> wrote:

> As I understood, with HT enabled, Linux-SMP sees four CPUs with 5000 bogo mips 
> each (of course I've already seen this in /proc/cpuinfo).
> 
> So, if I deactivate HT, will a UP Linux see one CPU with 4x5000=20000 bogo 
> mips?

No. It will see one CPU with 5000 BogoMips.

Matt
