Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129736AbRCARNY>; Thu, 1 Mar 2001 12:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129737AbRCARNG>; Thu, 1 Mar 2001 12:13:06 -0500
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:32458 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S129736AbRCARMx>; Thu, 1 Mar 2001 12:12:53 -0500
Date: Thu, 1 Mar 2001 18:12:50 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ivan Stepnikov <iv@spylog.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel is unstable
Message-ID: <20010301181250.H20364@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <001701c0a230$40e12240$0e04a8c0@iv> <20010301152409.E32484@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010301152409.E32484@athlon.random>; from andrea@suse.de on Thu, Mar 01, 2001 at 03:24:09PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2001 at 03:24:09PM +0100, Andrea Arcangeli wrote:
> On Thu, Mar 01, 2001 at 12:16:08PM +0300, Ivan Stepnikov wrote:
> >                 if(p==malloc(block)){
> 
> Side note: I guess here you meant:
> 
> 		  if ((p = malloc(block)) {
 
<nitpick>
Actually 
 
 		  if ((p = malloc(block))) {

would be even correct C ;-)
</nitpick>

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
