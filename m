Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316621AbSEQRQL>; Fri, 17 May 2002 13:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316622AbSEQRQK>; Fri, 17 May 2002 13:16:10 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:47120
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S316621AbSEQRQJ>; Fri, 17 May 2002 13:16:09 -0400
Date: Fri, 17 May 2002 10:15:31 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Todd R. Eigenschink" <todd@tekinteractive.com>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
Subject: Re: kswapd OOPS under 2.4.19-pre8 (ext3, Reiserfs + (soft)raid0)
Message-ID: <20020517171531.GE627@matchmail.com>
Mail-Followup-To: "Todd R. Eigenschink" <todd@tekinteractive.com>,
	vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
In-Reply-To: <15577.5431.625191.582701@rtfm.ofc.tekinteractive.com> <15585.10390.825902.226132@rtfm.ofc.tekinteractive.com> <200205150849.g4F8n6Y12694@Port.imtp.ilyichevsk.odessa.ua> <15586.64093.770227.324620@rtfm.ofc.tekinteractive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2002 at 07:16:29PM -0500, Todd R. Eigenschink wrote:
> I just reset after another oops.  It's similar to, but different from,
> the previous one; the call stack is the same but they die in different
> places.
> 
> I put the output of "gcc -E" and "gcc -S" (with the rest of the
> command-line parameters) at the following URLs so you can see what the
> asm turned into on my machine (gcc 2.95.3); I'm not very x86-asm
> literate, so most of it's $FOREIGN_LANG to me.
> 

Have you tried testing the memory and power supply?
