Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129213AbQKFXPT>; Mon, 6 Nov 2000 18:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129496AbQKFXPJ>; Mon, 6 Nov 2000 18:15:09 -0500
Received: from quicksilver.ukc.ac.uk ([129.12.21.11]:4768 "EHLO
	quicksilver.ukc.ac.uk") by vger.kernel.org with ESMTP
	id <S129213AbQKFXO7>; Mon, 6 Nov 2000 18:14:59 -0500
Date: Mon, 6 Nov 2000 23:14:56 +0000
From: Adam Sampson <ats1@ukc.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: non-gcc linux?
Message-ID: <20001106231456.A14197@cartman.ukc.ac.uk>
Reply-To: azz@gnu.org
Mail-Followup-To: Adam Sampson <ats1@ukc.ac.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <fa.fvk85sv.1oigpiv@ifi.uio.no> <fa.cq7bdsv.gggbio@ifi.uio.no> <ylu29mey6f.fsf@windlord.stanford.edu> <3A0602E9.D59F2E50@Rikers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3A0602E9.D59F2E50@Rikers.org>; from Tim@Rikers.org on Sun, Nov 05, 2000 at 06:01:29PM -0700
X-Homepage: http://cider.bnet-ibb.de/~azz/
X-Planation: RSA in 2 lines Perl: see http://dcs.ex.ac.uk/~aba/x.html
X-Munition-Export: print pack"C*",split/\D+/,`echo "16iII*o\U@{$/=$z;[(pop,pop,unpack"H*",<>)]}\EsMsKsN0[lN*1lK[d2%Sa2/d0<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<J]dsJxp"|dc`
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2000 at 06:01:29PM -0700, Tim Riker wrote:
> In short the impact of adding code to gcc that is not copyright FSF is
> minimal. Only the FSF copyrighted code would be defensible by the FSF. Any
> other code GPL violations would be the responsibility of the copyright
> owners to defend.

Just as a minor point: pro64 _does_ use GCC code. It's effectively the GCC
frontend stuck together with the SGI backend, with a translation layer in
the middle to translate between the intermediate code formats that the two
compilers use. There are some fairly entertaining "this is a gruesome hack"
comments in the source code.

-- 

Adam Sampson
azz@gnu.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
