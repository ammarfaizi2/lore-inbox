Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279430AbRJWNkp>; Tue, 23 Oct 2001 09:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279432AbRJWNkf>; Tue, 23 Oct 2001 09:40:35 -0400
Received: from dark.pcgames.pl ([195.205.62.2]:8920 "EHLO dark.pcgames.pl")
	by vger.kernel.org with ESMTP id <S279430AbRJWNkX>;
	Tue, 23 Oct 2001 09:40:23 -0400
Date: Tue, 23 Oct 2001 15:39:32 +0200 (CEST)
From: Krzysztof Oledzki <ole@ans.pl>
X-X-Sender: <ole@dark.pcgames.pl>
To: <linux-kernel@vger.kernel.org>
Subject: kernel panic in 2.4.x
Message-ID: <Pine.LNX.4.33.0110231529460.17293-100000@dark.pcgames.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Why after kernel panic in 2.4.x it is not possible to do anything? It is
little annoying that, for example after entering wrong partition into
root=<>, I have to press reset key. It is not even possible to check
kernel messages (like names assigned to scsi and ide devices) with
Shift-PageUp. And ofcourse, during next boot, all raid arrays need to be
rebuild. 2.2.x kernels do not have this feature.


Best regards,

				Krzysztof Oledzki

