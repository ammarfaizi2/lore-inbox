Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268501AbUJDH1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268501AbUJDH1p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 03:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268497AbUJDH1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 03:27:45 -0400
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:33503 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S268501AbUJDH1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 03:27:37 -0400
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 04 Oct 2004 09:26:18 +0200
MIME-Version: 1.0
Subject: Re: [OT] Re: patches inline in mail
Cc: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>, george@mvista.com,
       Andrew Morton <akpm@osdl.org>, juhl-lkml@dif.dk, clameter@sgi.com,
       drepper@redhat.com, johnstul@us.ibm.com,
       Ulrich.Windl@rz.uni-regensburg.de, jbarnes@sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       libc-alpha@sources.redhat.com
Message-ID: <4161173B.2599.4F3841@rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <Pine.LNX.4.60.0410032255360.5054@poirot.grange>
References: <1096730402.25131.18.camel@localhost.localdomain>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-3.84+2.20+2.07.066+02 August 2004+93665@20041004.072529Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Better show how the mail really looks like (source). The let's see whether it's a 
decoding or encoding error.

Ulrich

On 3 Oct 2004 at 23:01, Guennadi Liakhovetski wrote:

> Hello
> 
> While we are at it, maybe someone could help me with my "antient" pine 
> too. When sending patches inline (Ctrl-R) it looks fine up in the email, 
> also when I am reading my own email as it came to the list, e.g.
> 
> @@ -8,9 +8,9 @@
>   static void __inline__
>   dc390_freetag (struct dc390_dcb* pDCB, struct dc390_srb* pSRB)
>   {
> -	if (pSRB->TagNumber < 255) {
> 
> However, everybody (not pine-users) complains, that white spaces got 
> corrupted. And if I export the email I see
> 
> @@ -8,9 +8,9 @@
>    static void __inline__
>    dc390_freetag (struct dc390_dcb* pDCB, struct dc390_srb* pSRB)
>    {
> -	if (pSRB->TagNumber < 255) {
> 
> (notice the extra space). What is going on there and is there a solution 
> (apart from switching to another mailing or sending as attachments)?
> 
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski
> 


