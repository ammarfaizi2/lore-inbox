Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293253AbSCAQ11>; Fri, 1 Mar 2002 11:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293249AbSCAQ1R>; Fri, 1 Mar 2002 11:27:17 -0500
Received: from vn2-p18.craftech.com ([207.106.69.66]:18562 "EHLO
	ghoti.dhis.org") by vger.kernel.org with ESMTP id <S293245AbSCAQ1E>;
	Fri, 1 Mar 2002 11:27:04 -0500
Date: Fri, 1 Mar 2002 11:17:20 -0500
From: Tim Peeler <timpeeler@comcast.net>
To: linux-kernel@vger.kernel.org
Subject: Re: BUG _llseek kernel 2.4.17
Message-ID: <20020301161720.GA1621@comcast.net>
Mail-Followup-To: Tim Peeler <timpeeler@comcast.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020301080327.GA18948@comcast.net> <010a01c1c10f$45a695e0$5a5b903f@h90>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010a01c1c10f$45a695e0$5a5b903f@h90>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2002 at 05:53:07AM -0500, Joseph Malicki wrote:
> Sparse files.  If you never wrote to it, it never got a block on disk... the
> kernel will return zeroes for said portions of file when you read it.

Got it.  Had no idea what sparse files were, did a google on 'em.  Now I
get it.  

Thanks,  
Tim

-- 
@a=(Lbzjoftt,Inqbujfodf,Hvcsjt); $b="Lbssz Wbmm"
;$b =~ y/b-z/a-z/ ; $c =" Tif ". @a ." hsfbu wj"
."suvft pg b qsphsbnnfs". ":\n";$c =~y/b-y/a-z/;
print"\n\n$c ";for($i=0;$i<@a; $i++) { $a[$i] =~
y/b-y/a-z/;if($a[$i]eq$a[-1]){print"and $a[$i]."
;}else{ print"$a[$i], ";}}print"\n\t\t--$b\n\n";
