Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261474AbSIPM10>; Mon, 16 Sep 2002 08:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261464AbSIPM1Z>; Mon, 16 Sep 2002 08:27:25 -0400
Received: from 62-190-219-96.pdu.pipex.net ([62.190.219.96]:55047 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S261408AbSIPM1V>; Mon, 16 Sep 2002 08:27:21 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209161239.g8GCdpgO001846@darkstar.example.net>
Subject: Re: [PATCH] Experimental IDE oops dumper v0.1
To: linux-kernel@vger.kernel.org
Date: Mon, 16 Sep 2002 13:39:51 +0100 (BST)
Cc: alan@redhat.com, rusty@rustcorp.com.au
In-Reply-To: <200209161218.g8GCI7301692@devserv.devel.redhat.com> from "Alan Cox" at Sep 16, 2002 08:18:07 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Talking about dumping oopsen, would there be any usefulness in outputting crash data to the PC speaker, using a slow, (~300 bps) modulation that would survive being captured on a cassette using a walkman with a microphone, then decoded using a userspace program from a sampled .au file?

Just thought it might be easily implementable, as it doesn't have any pre-requisits, (other than having a PC speaker, which *almost* everybody has).

John.
