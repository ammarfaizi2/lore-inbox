Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267565AbRGXPgK>; Tue, 24 Jul 2001 11:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267567AbRGXPgB>; Tue, 24 Jul 2001 11:36:01 -0400
Received: from bigred.kinkaid.org ([207.80.142.5]:26332 "EHLO kinkaid.org")
	by vger.kernel.org with ESMTP id <S267565AbRGXPft>;
	Tue, 24 Jul 2001 11:35:49 -0400
From: <kernel-list@kinkaid.org>
Subject: dqblk or mem_dqblk for quotas?
To: linux-kernel@vger.kernel.org
X-Mailer: CommuniGate Pro Web Mailer v.3.4.6
Date: Tue, 24 Jul 2001 10:45:22 -0500
Message-ID: <web-233042@kinkaid.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello all -

Recently, I've been trying to write a utility to edit quotas
(specifically on an ext2 filesystem), using the 2.4.x
kernel. The man page for quotactl() on my system (RH 7.1)
refer to the mem_dqblk struct, which is nowhere to be found
in the source to the 2.4 kernels.

Am I missing something, or should I just continue to use the
dqblk struct.

Thanks in advance for any help -

--
-Jeff Thompson (http://jeff.zaius.org)
jeff@zaius.org
