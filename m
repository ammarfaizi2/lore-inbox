Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317140AbSFQW5h>; Mon, 17 Jun 2002 18:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317141AbSFQW5g>; Mon, 17 Jun 2002 18:57:36 -0400
Received: from [194.46.8.33] ([194.46.8.33]:14865 "EHLO angusbay.vnl.com")
	by vger.kernel.org with ESMTP id <S317140AbSFQW5g>;
	Mon, 17 Jun 2002 18:57:36 -0400
Date: Tue, 18 Jun 2002 00:00:02 +0100
From: Dale Amon <amon@vnl.com>
To: linux-kernel@vger.kernel.org
Subject: Eisa option problem in 2.5.22
Message-ID: <20020617230002.GC24436@vnl.com>
Mail-Followup-To: Dale Amon <amon@vnl.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux, the choice of a GNU generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A minor build problem. I turned the EISA bus option off and then it
successfully compiled.

make[1]: *** No rule to make target `eisa.o', needed by `kernel.o'.  Stop.
make: *** [arch/i386/kernel] Error 2

