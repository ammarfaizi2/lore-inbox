Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317782AbSHCVDm>; Sat, 3 Aug 2002 17:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317791AbSHCVDl>; Sat, 3 Aug 2002 17:03:41 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:11405 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317782AbSHCVCj>; Sat, 3 Aug 2002 17:02:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: linux-kernel@vger.kernel.org
Subject: question on dup_task_struct
Date: Sat, 3 Aug 2002 22:34:17 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <17b65z-1ERay0C@fmrl02.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

why is GFP_ATOMIC used in fork.c::dup_task_struct?

	TIA
		Oliver


	
