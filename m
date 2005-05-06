Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVEFQn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVEFQn7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 12:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVEFQn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 12:43:59 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:54421 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261157AbVEFQnz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 12:43:55 -0400
In-Reply-To: <20050506080437.GE4604@pclin040.win.tue.nl>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Joe <joecool1029@gmail.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, "Randy.Dunlap" <rddunlap@osdl.org>
MIME-Version: 1.0
Subject: Re: Empty partition nodes not created (was device node issues with recent
 mm's and udev)
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF36D48B29.45D85BB9-ON88256FF9.005B311E-88256FF9.005BEEB7@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Fri, 6 May 2005 09:43:37 -0700
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V70_04122005|April 12, 2005) at
 05/06/2005 12:43:54,
	Serialize complete at 05/06/2005 12:43:54
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>There is a misunderstanding in terminology here.
>"DOS-type partition table" is for most Linux users the only type
>they have ever seen. The msdos in this context does not refer
>to a particular filesystem, like the fat or msdos filesystem.

As long as we're talking terminology: fat and msdos aren't particular 
filesystems.  They're particular filesystem types.  The contents of a 
particular DOS-fomatted floppy disk would be an example of a particular 
filesystem.

--
Bryan Henderson                          IBM Almaden Research Center
San Jose CA                              Filesystems
