Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132855AbRADMOx>; Thu, 4 Jan 2001 07:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132919AbRADMOn>; Thu, 4 Jan 2001 07:14:43 -0500
Received: from f1j.dsl.xmission.com ([166.70.20.140]:63017 "EHLO
	f1j.dsl.xmission.com") by vger.kernel.org with ESMTP
	id <S132855AbRADMOW>; Thu, 4 Jan 2001 07:14:22 -0500
Message-ID: <3A5468F0.AC7388AE@xmission.com>
Date: Thu, 04 Jan 2001 05:13:36 -0700
From: Frank Jacobberger <f1j@xmission.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-prerelease i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: exit.c -prerelease-diff - Jan 4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

+          current->state = TASK_ZOMBIE;

Why the update on exit.c to include TASK_ZOMBIE?

Thanks,

Frank -

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
