Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132574AbRDAWuh>; Sun, 1 Apr 2001 18:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132577AbRDAWu2>; Sun, 1 Apr 2001 18:50:28 -0400
Received: from monza.monza.org ([209.102.105.34]:16909 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S132574AbRDAWuN>;
	Sun, 1 Apr 2001 18:50:13 -0400
Date: Sun, 1 Apr 2001 15:49:05 -0700
From: Tim Wright <timw@splhi.com>
To: Philip Blundell <philb@gnu.org>
Cc: LA Walsh <law@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: unistd.h and 'extern's and 'syscall' "standard(?)"
Message-ID: <20010401154905.B4455@kochanski>
Reply-To: timw@splhi.com
Mail-Followup-To: Philip Blundell <philb@gnu.org>, LA Walsh <law@sgi.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3AC75DBF.31594195@sgi.com> <jelmpktors.fsf@hawking.suse.de> <3AC78E24.98DEA986@sgi.com> <law@sgi.com> <E14jocC-0008Jg-00@kings-cross.london.uk.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <E14jocC-0008Jg-00@kings-cross.london.uk.eu.org>; from philb@gnu.org on Sun, Apr 01, 2001 at 09:38:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And furthermore, it's been around in Unix and unix-like systems for a very long
time. Sounds like the lack of man page is an oversight. Anybody want to write
one ?

Tim

On Sun, Apr 01, 2001 at 09:38:24PM +0100, Philip Blundell wrote:
> >of action to take.  Seeing as you work for suse, would you know
> >where this 'syscall(3)' interface should be documented?  Is it
> >supposed to be present in all distro's?  
> 
> It's documented in the glibc manual.  Yes, it should be present in all glibc 
> based distributions.
> 
> p.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
