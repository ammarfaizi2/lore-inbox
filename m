Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130038AbREALfg>; Tue, 1 May 2001 07:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131317AbREALf0>; Tue, 1 May 2001 07:35:26 -0400
Received: from femail4.sdc1.sfba.home.com ([24.0.95.84]:34225 "EHLO
	femail4.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S130038AbREALfS>; Tue, 1 May 2001 07:35:18 -0400
Message-ID: <3AEE9EA0.3752F0C0@home.com>
Date: Tue, 01 May 2001 04:31:44 -0700
From: Seth Goldberg <bergsoft@home.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Followup to previous post: Atlon/VIA Instabilities
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  So it seems that CONFIG_X86_USE_3DNOW is simply used to
enable access to the routines in mmx.c (the athlon-optimized
routines on CONFIG_K7 kernels), so then it appears that somehow
this is corrupting memory / not behaving as it should (very
technical, right?) :)...

 --Seth
