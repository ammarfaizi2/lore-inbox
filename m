Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288686AbSADRIN>; Fri, 4 Jan 2002 12:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288687AbSADRIE>; Fri, 4 Jan 2002 12:08:04 -0500
Received: from [63.170.174.196] ([63.170.174.196]:270 "EHLO
	localhost.seg.inf.cu") by vger.kernel.org with ESMTP
	id <S288686AbSADRH4>; Fri, 4 Jan 2002 12:07:56 -0500
Message-Id: <200201041721.g04HLoR04447@tiger.seg.inf.cu>
Content-Type: text/plain; charset=US-ASCII
From: Israel Fernandez Cabrera <israel@seg.inf.cu>
Organization: Segurmatica
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: IPC message
Date: Fri, 4 Jan 2002 12:06:43 -0500
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, could somebody tell why I can't send IPC messages from a kernel module. 
The module is able to create the queue, but when I use an 'ipcs -q' command I 
never have seen a message waiting.
I'll appreciate any hint
regards
elfo
