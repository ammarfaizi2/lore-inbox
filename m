Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261377AbSJCU1j>; Thu, 3 Oct 2002 16:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261386AbSJCU1i>; Thu, 3 Oct 2002 16:27:38 -0400
Received: from fmr02.intel.com ([192.55.52.25]:41936 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S261377AbSJCU1h>; Thu, 3 Oct 2002 16:27:37 -0400
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DF01@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Kai Germaschewski'" <kai-germaschewski@uiowa.edu>,
       kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: RE: [kbuild-devel] RfC: Don't cd into subdirs during kbuild
Date: Thu, 3 Oct 2002 13:33:02 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Kai Germaschewski [mailto:kai-germaschewski@uiowa.edu] 
> ChangeSet@1.677, 2002-10-02 14:46:16-05:00, kai@tp1.ruhr-uni-bochum.de
>   kbuild: Standardize ACPI Makefiles
>   
>   ACPI was a bit lazy and just said compile all .c files in 
> this directory,
>   which is different from all other Makefiles and will not work very
>   well e.g. bk, where a .c file may not be checked out yet, 
> or separate
>   obj/src dirs. So just explicitly list the files we want to compile.

Excellent, I was just going to fix this, and now I don't have to ;-)

-- Andy
