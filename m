Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318065AbSHQSOU>; Sat, 17 Aug 2002 14:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318093AbSHQSOU>; Sat, 17 Aug 2002 14:14:20 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:52185 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S318065AbSHQSOU>; Sat, 17 Aug 2002 14:14:20 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200208171816.g7HIGl611376@devserv.devel.redhat.com>
Subject: Re: [PATCH][RFC] sigurg/sigio cleanup for 2.5.31
To: jmorris@intercode.com.au (James Morris)
Date: Sat, 17 Aug 2002 14:16:47 -0400 (EDT)
Cc: jdike@karaya.com (Jeff Dike), alan@redhat.com (Alan Cox),
       davem@redhat.com (David S. Miller), kuznet@ms2.inr.ac.ru,
       ak@muc.de (Andi Kleen), linux-kernel@vger.kernel.org,
       willy@debian.org (Matthew Wilcox)
In-Reply-To: <Mutt.LNX.4.44.0208170125020.1403-100000@blackbird.intercode.com.au> from "James Morris" at Aug 17, 2002 01:59:58 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like the lock is needed - oh well
