Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbUKUTmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbUKUTmI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 14:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbUKUTmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 14:42:08 -0500
Received: from web41407.mail.yahoo.com ([66.218.93.73]:60586 "HELO
	web41407.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261801AbUKUTmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 14:42:03 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=ya3gLRnd0NjE33jEth5wMIZmMME4rIvkQQEmfrzTNK8UG1UAlgOKmQXcsGt+K8vuV3dEl2htVS+9NJmgVT8NV5vwscxoTuHMmaa5Keqfq9B3X4DzJuC2gX4Ofnd0DHDRDgthqgtdFLWlH3t0p2PiYqHKnJmRyB86kdzUte4y8pc=  ;
Message-ID: <20041121194202.14581.qmail@web41407.mail.yahoo.com>
Date: Sun, 21 Nov 2004 11:42:02 -0800 (PST)
From: cranium2003 <cranium2003@yahoo.com>
Subject: Re: how netfilter handles fragmented packets
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, netdev@oss.sgi.com
In-Reply-To: <29495f1d04112109372bb8ebe4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Nish Aravamudan <nish.aravamudan@gmail.com> wrote:
Hello Nish,

> On Sun, 21 Nov 2004 17:15:12 +0100 (MET), Jan
> Engelhardt
> <jengelh@linux01.gwdg.de> wrote:
> > >hello,
> > >          In ip_output.c file ip_fragmet function
> when
> > >create a new fragmented packet given to
> output(skb)
> > >function. i want to know which function are
> actually
> > >called by output(skb)?
> > 
> > use stack_dump() (or was it dump_stack()?)
> 
> dump_stack(), if you want to dump the current
> process' stack context.
> 
> -Nish
> 

can you please tell me how can i use dump_stack()
method? so using dump_stack i will come to know which
function will be called by output(skb) right? But
where i get dump_stack()???
regards,
cranium


		
__________________________________ 
Do you Yahoo!? 
Meet the all-new My Yahoo! - Try it today! 
http://my.yahoo.com 
 

