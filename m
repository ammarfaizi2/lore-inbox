Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbVLPRRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbVLPRRb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 12:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbVLPRRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 12:17:31 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:16965 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S932358AbVLPRRa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 12:17:30 -0500
Subject: RE:  Re: gtkpod and Filesystem
From: Kasper Sandberg <lkml@metanurb.dk>
To: "Bonilla, Alejandro" <alejandro.bonilla@hp.com>
Cc: Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>, linux-kernel@vger.kernel.org,
       debian-devel@lists.debian.org
In-Reply-To: <F265D57E1F28274EA189ED0566D227DE7F22CD@PGJEXC01.americas.cpqcorp.net>
References: <F265D57E1F28274EA189ED0566D227DE7F22CD@PGJEXC01.americas.cpqcorp.net>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 18:17:22 +0100
Message-Id: <1134753442.25512.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-16 at 10:32 -0600, Bonilla, Alejandro wrote:
> Gunter,
> 
> 	Actually. Issue fixed. It is really odd that a dosfsck fixed it.
i dont see how that is odd.. if the filesystem was somehow corrupted
dosfsck would have corrected it.
> ;-)
> 
> Thanks,
> 
> .Alejandro
> 
> ||Alejandro Bonilla wrote:
> ||> I have Debian Sid with 2.6.15-rc5, I wonder if this could be 
> ||either with a
> ||> bug in gtkpod or the kernel (FS Panic).
> ||
> ||Maybe an FS error on your iPod? Did you try to reformat or dosfsck it?
> |
> |I doubt it, I mean, it works well in Windows and while 
> |playing. It is only giving trouble in Linux.
> |
> |I will look deeper into it, I was just wondering if the FS 
> |Errors where familiar.
> |
> |Thanks,
> |
> |.Alejandro
> |
> ||
> ||Greetings,
> ||
> ||  Gunter
> |
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

