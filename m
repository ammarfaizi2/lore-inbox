Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267020AbTGTMfZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 08:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267026AbTGTMfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 08:35:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22658 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267020AbTGTMfV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 08:35:21 -0400
Date: Sun, 20 Jul 2003 13:50:19 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Alain.BASTIDE@univ-reunion.fr
Cc: linux-kernel@vger.kernel.org
Subject: Re: Trans.: Re: AMD Athlon MP Machine check exceptions
Message-ID: <20030720125019.GC628@gallifrey>
References: <1058703292.3f1a87bcc6b1a@imp.univ-reunion.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1058703292.3f1a87bcc6b1a@imp.univ-reunion.fr>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.0-test1 (i686)
X-Uptime: 13:46:30 up 13:57,  1 user,  load average: 0.02, 0.03, 0.06
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alain.BASTIDE@univ-reunion.fr (Alain.BASTIDE@univ-reunion.fr) wrote:
> Hi 

Hi Alain,

>  i had the same problem whith a MSI 6501 AMD MP 2000+!!!! and now it's worked!!!!
> 
>  I compile one kernel and when i start  mbmon (
> http://www.nt.phys.kyushu-u.ac.jp/shimizu/download/download.html ) 
> 
> i saw 
> Temp.= 32.0, 73.5, 65.5; Rot.= 2596, 4821, 2636
> Vcore = 1.66, 2.54; Volt. = 3.34, 4.84, 12.40, -12.78, -5.00

There were known problems with temperature measurements on some Athlon
MP systems where two different programs report temperatures 30deg apart
- so it is never obvious what to believe!


> it was amazing cause bios said ~40°C
> 
>  I compile a new kernel where i change options and now i haven't  got this
> message and mbmon say :

Which options?

Dave
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
