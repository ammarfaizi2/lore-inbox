Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293536AbSBZHsB>; Tue, 26 Feb 2002 02:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293537AbSBZHrv>; Tue, 26 Feb 2002 02:47:51 -0500
Received: from codepoet.org ([166.70.14.212]:21933 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S293536AbSBZHrg>;
	Tue, 26 Feb 2002 02:47:36 -0500
Date: Tue, 26 Feb 2002 00:47:39 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Andrew Hatfield <lkml@secureone.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Patch Symantics
Message-ID: <20020226074738.GA6108@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Andrew Hatfield <lkml@secureone.com.au>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <075501c1be93$f6cc2b10$0f01000a@brisbane.hatfields.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <075501c1be93$f6cc2b10$0f01000a@brisbane.hatfields.com.au>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.17-rmk5, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Feb 26, 2002 at 05:05:19PM +1000, Andrew Hatfield wrote:
> What would be wonderful (mjc, riel) is if your patch diffs actually put
> their modifications into linux/ and not b

bzcat <patch> | patch -p1 -d <linux dir>

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
