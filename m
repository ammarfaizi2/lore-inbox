Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318294AbSHKMyh>; Sun, 11 Aug 2002 08:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318295AbSHKMyh>; Sun, 11 Aug 2002 08:54:37 -0400
Received: from ns.suse.de ([213.95.15.193]:59916 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318294AbSHKMyh> convert rfc822-to-8bit;
	Sun, 11 Aug 2002 08:54:37 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: Oliver Neukum <oliver@neukum.name>
Subject: Re: question xattr methods
Date: Sun, 11 Aug 2002 14:58:23 +0200
X-Mailer: KMail [version 1.4]
References: <200208101941.37358.oliver@neukum.name>
In-Reply-To: <200208101941.37358.oliver@neukum.name>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208111458.23401.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Saturday 10 August 2002 19:41, Oliver Neukum wrote:
> Hi,
>
> is there any documentation or examples of their use?
>
> I want to convert hfs to using them and thus looking
> for information on them.
>
> 	Regards
> 		Oliver

There are manual pages on the concepts and xattr syscalls and kernel as well 
as user space code at <http://acl.bestbits.at/>, and a CVS repository at 
<http://oss.sgi.com/projects/xfs/>. For implementing the kernel code please 
take a look at the ext2/ext3 patches. If you have further questions, the 
appropriate forum would be the acl-devel@bestbits.at mailing list, 
<http://acl.bestbits.at/mailman/listinfo/acl-devel/>, and also the 
<linux-fsdevel@vger.kernel.org> list.

Regards,
Andreas.

------------------------------------------------------------------
 Andreas Gruenbacher                                SuSE Linux AG
 mailto:agruen@suse.de                     Deutschherrnstr. 15-19
 http://www.suse.de/                   D-90429 Nuernberg, Germany

