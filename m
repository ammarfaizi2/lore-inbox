Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286209AbSAEBIg>; Fri, 4 Jan 2002 20:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286177AbSAEBI0>; Fri, 4 Jan 2002 20:08:26 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:43446 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S286179AbSAEBIK>; Fri, 4 Jan 2002 20:08:10 -0500
To: Andreas Dilger <adilger@turbolabs.com>
Cc: acme@conectiva.com.br, Andries.Brouwer@cwi.nl, ion@cs.columbia.edu,
        linux-fsdevel@vger.kernel.org, linux-fsdevel-owner@vger.kernel.org,
        linux-kernel@vger.kernel.org, phillips@bonn-fries.net
MIME-Version: 1.0
Subject: Re: [CFT] [JANITORIAL] Unbork fs.h
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFF6EC0FD7.EAA5F4A2-ON87256B38.0005251C@boulder.ibm.com>
From: "Bryan Henderson" <hbryan@us.ibm.com>
Date: Fri, 4 Jan 2002 18:07:17 -0700
X-MIMETrack: Serialize by Router on D03NM031/03/M/IBM(Release 5.0.9 |November 16, 2001) at
 01/04/2002 06:07:17 PM,
	Serialize complete at 01/04/2002 06:07:17 PM
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Well Lindent != indent.  The "indent" program can do formatting to the
>wishes of the user.  However, "Lindent" is a wrapper script which is
>trying to impose the will of Linus on other kernel programmers,

Ah.  I must have been confused (never having seen Lindent or Indent 
myself).  We're talking about options Lindent passes to Indent?  I thought 
we were talking about new options on Lindent.  Options on Lindent don't 
really make sense.

In that case, I should modify my earlier observation and say Lindent 
shouldn't follow the majority either because it defines good style _or_ 
because it achieves consistency.  It should do it because the majority 
style is evidence of what Linus likes.

