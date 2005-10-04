Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbVJDRXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbVJDRXv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 13:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbVJDRXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 13:23:51 -0400
Received: from free.hands.com ([83.142.228.128]:37262 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S964860AbVJDRXv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 13:23:51 -0400
Date: Tue, 4 Oct 2005 18:23:38 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051004172338.GZ10538@lkcl.net>
References: <20051002204703.GG6290@lkcl.net> <54300000.1128297891@[10.10.2.4]> <20051003011041.GN6290@lkcl.net> <200510022028.07930.chase.venters@clientec.com> <20051004125955.GQ10538@lkcl.net> <17218.39427.421249.448094@gargle.gargle.HOWL> <20051004161702.GU10538@lkcl.net> <17218.47309.332739.836271@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17218.47309.332739.836271@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2005 at 09:15:57PM +0400, Nikita Danilov wrote:
> Luke Kenneth Casson Leighton writes:
> 
> [...]
> 
>  > 
>  >  assuming that you have an intelligent programmer (or some really good
>  >  and working parallelisation tools) who really knows his threads?
> 
> Well, I'd like to have a hardware with CAS-n operation for one
> thing. 

 CAS - compare and swap - by CAS-n i presume that you mean effectively a
 SIMD CAS instruction?

> But what would this buy us? 

 you do not say :)  i am genuinely interested to hear what it would buy.

> Having different kernel algorithms
> for x86 and mythical cas-n-able hardware is not viable.

 if i can get an NPTL .deb package for glibc for x86 only it would tend
 to imply that that isn't a valid conclusion: am i missing something?

 cheers,

 l.
 
 
