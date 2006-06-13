Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbWFMJ62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbWFMJ62 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 05:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbWFMJ61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 05:58:27 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:34985 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750864AbWFMJ60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 05:58:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dic7DRQEPfrPtxzdSgAHnFRCDHHF+hPkLaDuMs5km30+nmwtkDBgEa+FY8kyjj9zl4Emb86Fyn80RYmKUVFcI3bmCqRTF3DuA/+eLPiQnJsa+CXQ4gjgu4UW4C4J8S+jZkgtvnFi+83GcQgAo1c9yAz4mO9Rsy1nA1nxuegrHk4=
Message-ID: <9a8748490606130258k60cdf429n89b1d1d017af60fe@mail.gmail.com>
Date: Tue, 13 Jun 2006 11:58:26 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "dezheng shen" <dzshen@winbond.com>
Subject: Re: [Winbond] flash memory reader SCSI device drivers
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "PI14 SJIN" <SJin@winbond.com>
In-Reply-To: <448E875A.40805@winbond.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <448E875A.40805@winbond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/06, dezheng shen <dzshen@winbond.com> wrote:
>
>  We would like to contribute our flash memory device drivers to Linux
> community and would like to post to a public list for review first.
>
That's nice. Thank you.

Please review the following files before posting the patches :

  Documentation/CodingStyle
  Documentation/SubmittingDrivers
  Documentation/SubmittingPatches

and make sure you've cleaned up the code to follow CodingStyle -
otherwise that's just going to be the first thing people will tell you
to fix :-)

Also make sure you include appropriate "Signed-off-by:" lines on the
patches and please post patches inline, not as attachments (and please
test send those mails to yourself first and check that the patches
apply and have not been mangled by your email client).


>  This is the first we send this request to this mailing list and we are
> not sure this is the right way to do. If any of you is interested in
> reviewing our sources for Memory Stick driver for Winbond w518 chip,
> please let me know so that we can post our sources.
>
I don't have the appropriate hardware, but I'd still be interrested in
taking a look at the patches, and I'm sure many other people feel the
same way.
I'd say posting the patches on LKML and adding relevant people/lists
from the MAINTAINERS file to Cc would be the way to do it.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
