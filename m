Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316788AbSHGB3K>; Tue, 6 Aug 2002 21:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316789AbSHGB3K>; Tue, 6 Aug 2002 21:29:10 -0400
Received: from codepoet.org ([166.70.99.138]:20680 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S316788AbSHGB3J>;
	Tue, 6 Aug 2002 21:29:09 -0400
Date: Tue, 6 Aug 2002 19:32:51 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK-PATCH-2.5] NTFS 2.0.24: Cleanups
Message-ID: <20020807013250.GA30858@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Anton Altaparmakov <aia21@cantab.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <E17cFG4-0007hW-00@storm.christs.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17cFG4-0007hW-00@storm.christs.cam.ac.uk>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Aug 07, 2002 at 02:05:04AM +0100, Anton Altaparmakov wrote:
>    - Do not allow read-write remounts of read-only volumes with errors.

I thought the current NTFS driver does not yet support writing...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
