Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751519AbWEUKpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbWEUKpk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 06:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbWEUKpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 06:45:40 -0400
Received: from ns.dynamicweb.hu ([195.228.155.139]:35543 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1751519AbWEUKpj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 06:45:39 -0400
Message-ID: <01b001c67cc3$a3d303a0$1800a8c0@dcccs>
From: =?iso-8859-1?Q?Haar_J=E1nos?= <djani22@netcenter.hu>
To: "Chris Wedgwood" <cw@f00f.org>
Cc: <linux-kernel@vger.kernel.org>
References: <00e901c67cad$fe9a9d90$1800a8c0@dcccs> <20060521081621.GA1151@taniwha.stupidest.org> <010801c67cb1$bc13fd00$1800a8c0@dcccs> <20060521084728.GA2535@taniwha.stupidest.org> <012201c67cb5$7a213800$1800a8c0@dcccs> <20060521091022.GA3468@taniwha.stupidest.org> <014601c67cb9$4f235f30$1800a8c0@dcccs> <20060521102642.GB5582@taniwha.stupidest.org>
Subject: Re: swapper: page allocation failure.
Date: Sun, 21 May 2006 12:45:08 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Chris Wedgwood" <cw@f00f.org>
To: "Haar J?nos" <djani22@netcenter.hu>
Cc: <linux-kernel@vger.kernel.org>
Sent: Sunday, May 21, 2006 12:26 PM
Subject: Re: swapper: page allocation failure.


> On Sun, May 21, 2006 at 11:31:12AM +0200, Haar J?nos wrote:
>
> > [root@st-0001 /]# uname -a
> > Linux st-0001 2.6.17-rc3-git1 #2 SMP Sun May 21 01:12:22 CEST 2006 i686
i686 i386 GNU/Linux
>
> did earlier kernels work OK?

No, the my reboot problem starts about january, but my tracking progress is
slow because this is the first error message.
(On january i have upgrade the nodes, and  few things are changed.)


>
> > This is a simple disk node.
> > It serves the md0 array, and uses mem for buffering-caching.
>
> odd, i looks like you've leaked alot of lowmem but i can't think why
>
> i've got major (induced) brain-fog right now so i'll have to think
> about it tomorrow sorry

OK, thanks.

Cheers,
Janos

