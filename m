Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbRDBOHN>; Mon, 2 Apr 2001 10:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129443AbRDBOHE>; Mon, 2 Apr 2001 10:07:04 -0400
Received: from [195.180.174.223] ([195.180.174.223]:12160 "EHLO
	idun.neukum.org") by vger.kernel.org with ESMTP id <S129408AbRDBOG5>;
	Mon, 2 Apr 2001 10:06:57 -0400
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: linux-kernel@vger.kernel.org
Subject: how to let all others run
Date: Mon, 2 Apr 2001 16:05:34 +0200
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <01040216053401.01575@idun>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

is there a way to let all other runable tasks run until they block or return 
to user space, before the task wishing to do so is run again ?

	TIA
		Oliver
