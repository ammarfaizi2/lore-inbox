Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282916AbRL0Wlb>; Thu, 27 Dec 2001 17:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282904AbRL0WlV>; Thu, 27 Dec 2001 17:41:21 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:1887 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S282916AbRL0WlI>;
	Thu, 27 Dec 2001 17:41:08 -0500
Message-ID: <20011227234104.B4528@win.tue.nl>
Date: Thu, 27 Dec 2001 23:41:04 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Stephan von Krawczynski <skraw@ithnet.com>,
        "James Stevenson" <mistral@stev.org>
Cc: jlladono@pie.xtec.es, linux-kernel@vger.kernel.org
Subject: Re: 2.4.x kernels, big ide disks and old bios
In-Reply-To: <3C285B40.91A83EC7@jep.dhis.org> <001a01c18d77$a9e92ca0$0801a8c0@Stev.org> <20011226173307.34e25fe6.skraw@ithnet.com> <000701c18ed8$73f2b2d0$0801a8c0@Stev.org> <20011227195101.5bf120f9.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20011227195101.5bf120f9.skraw@ithnet.com>; from Stephan von Krawczynski on Thu, Dec 27, 2001 at 07:51:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2001 at 07:51:01PM +0100, Stephan von Krawczynski wrote:

> I don't know. I tried once with
> 
> 00:01.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
> 
> and it did not work. I could definitely not write beyond the 32 GB border. I
> replaced the mobo then.

Did you try setmax?
