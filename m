Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312676AbSDFRhn>; Sat, 6 Apr 2002 12:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312675AbSDFRhm>; Sat, 6 Apr 2002 12:37:42 -0500
Received: from gumby.it.wmich.edu ([141.218.23.21]:17073 "EHLO
	gumby.it.wmich.edu") by vger.kernel.org with ESMTP
	id <S312644AbSDFRhk>; Sat, 6 Apr 2002 12:37:40 -0500
Subject: Re: Linux 2.4.19pre5-ac3 swsusp panic
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org, swsusp@lister.fornax.hu
In-Reply-To: <200204060109.g36199g10373@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 06 Apr 2002 12:37:27 -0500
Message-Id: <1018114652.7477.2.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On WOLK 3.2 i use swsusp and it works just fine on my P4 system.  With
the ac kernel i get a panic whenever i try to suspend.  I tried
including the couple lines that i patched in WOLK 3.2's swsusp mentioned
in the swsusp mailing list and still it panics.  Perhaps it's due to the
Taskfile stuff i compiled with, i'll try it without that stuff next. 


wish i could take a screenshot of the panic

