Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310440AbSCGSdk>; Thu, 7 Mar 2002 13:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310442AbSCGSdb>; Thu, 7 Mar 2002 13:33:31 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:1039 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S310440AbSCGSdS>;
	Thu, 7 Mar 2002 13:33:18 -0500
From: Cort Dougan <cort@fsmlabs.com>
Date: Thu, 7 Mar 2002 11:33:01 -0700
To: Jean-Luc Leger <reiga@dspnet.fr.eu.org>, lm@bitmover.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Petition Against Official Endorsement of BitKeeper by Linux Maintainers
Message-ID: <20020307113301.E9231@host110.fsmlabs.com>
In-Reply-To: <20020307190234.T20273@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020307190234.T20273@dspnet.fr.eu.org>; from reiga@dspnet.fr.eu.org on Thu, Mar 07, 2002 at 07:02:34PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, Larry, you should have been written in python.

} On Thu, Mar 07, 2002 at 04:51:56PM +0000, Henning P. Schmiedehausen wrote:
} > Larry McVoy <lm@bitmover.com> writes:
} > >	# extract all the patches from 2.5.0 onward.
} > >	bk prs -hrv2.5.0.. |  while read x
} > >	do	bk export -tpatch -r$i > ~ftp/patches/patch-$i
} > >	done
} > [henning@henning henning]$ bk prs -hrv2.5.0.. |  while read x
} > while: Expression Syntax.
} > You obviously just _underlined_ the point, Larry.
} > ...
} > It's tcsh; before you ask.
} 
} tss ..
} 
} by the way, shouldn't it be "$x" in the second line ?
} or am I missing something ?
} 
} 	JL
} -
} To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
} the body of a message to majordomo@vger.kernel.org
} More majordomo info at  http://vger.kernel.org/majordomo-info.html
} Please read the FAQ at  http://www.tux.org/lkml/
