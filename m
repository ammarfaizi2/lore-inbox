Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287371AbSACQR6>; Thu, 3 Jan 2002 11:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287374AbSACQRs>; Thu, 3 Jan 2002 11:17:48 -0500
Received: from [63.170.174.196] ([63.170.174.196]:37382 "EHLO
	localhost.seg.inf.cu") by vger.kernel.org with ESMTP
	id <S287371AbSACQRg>; Thu, 3 Jan 2002 11:17:36 -0500
Message-Id: <200201031631.g03GVTm03210@tiger.seg.inf.cu>
Content-Type: text/plain; charset=US-ASCII
From: Israel Fernandez Cabrera <israel@seg.inf.cu>
Organization: Segurmatica
To: linux-kernel@vger.kernel.org
Subject: IPC V and kernel modules
Date: Thu, 3 Jan 2002 11:16:26 -0500
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I'm new in the kernel programming word, so I'm having a lot of 
difficults, the first one is this:
I need to use IPC V messages in a kernel module to communicate this one with 
a daemon, but I'm not sure that my module is sending the messages ok, because 
when I use a 'ipcs -q' command I don't see any message waiting.
I'll apreciate any help
regards
elfo
