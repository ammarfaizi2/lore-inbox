Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314273AbSD0QDN>; Sat, 27 Apr 2002 12:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314274AbSD0QDM>; Sat, 27 Apr 2002 12:03:12 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:18907 "EHLO
	pimout2-int.prodigy.net") by vger.kernel.org with ESMTP
	id <S314273AbSD0QDM>; Sat, 27 Apr 2002 12:03:12 -0400
Subject: Re: The tainted message
From: Richard Thrapp <rthrapp@sbcglobal.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E171TzX-0008PF-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 27 Apr 2002 11:03:05 -0500
Message-Id: <1019923391.8818.69.camel@wizard>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-04-27 at 10:20, Alan Cox wrote:
> More informative but I think too soft. It still implies we might want to
> hear about it but not reply. That isnt the case.
> 
> How about
> 
> Warning: The module you have loaded (%s) does not seem to have an open
> 	 source license. Please send any kernel problem reports to the
> 	 author of this module, or duplicate them from a boot without
> 	 ever loading this module before reporting them to the community
> 	 or your Linux vendor
> 
> ??

I like the wording of that.  I suggest that we change the words "an open
source license" to "a GPL-compatible license" since that's what we're
checking for (if I remember incorrectly, please correct me).  It might
also be important to put the license string in there somewhere.

-- Richard Thrapp

