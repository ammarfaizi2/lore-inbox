Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290744AbSBOTqZ>; Fri, 15 Feb 2002 14:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290729AbSBOTqP>; Fri, 15 Feb 2002 14:46:15 -0500
Received: from mail.cogenit.fr ([195.68.53.173]:57800 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S290744AbSBOTp4>;
	Fri, 15 Feb 2002 14:45:56 -0500
Date: Fri, 15 Feb 2002 20:45:51 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: Willy TARREAU <tarreau@aemiaif.lip6.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [SUCCESS] Linux 2.4.18-rc1
Message-ID: <20020215204551.A18608@fafner.intra.cogenit.fr>
In-Reply-To: <E16bo2F-0000iJ-00@aemiaif.lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16bo2F-0000iJ-00@aemiaif.lip6.fr>; from tarreau@aemiaif.lip6.fr on Fri, Feb 15, 2002 at 08:28:43PM +0100
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy TARREAU <tarreau@aemiaif.lip6.fr> :
[...]
> I also slightly patched procfs to allow comx to link. It requires
> proc_get_inode() which was not exported (that's what my patch does),

Please don't do that. comx should to be fixed. Question was raised on l-k 
some months ago.

-- 
Ueimor
