Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273065AbRJTMOl>; Sat, 20 Oct 2001 08:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273108AbRJTMOb>; Sat, 20 Oct 2001 08:14:31 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:9479 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S273065AbRJTMOS>; Sat, 20 Oct 2001 08:14:18 -0400
Date: Sat, 20 Oct 2001 14:14:54 +0200
From: thunder7 <thunder7@xs4all.nl>
To: Krzysztof Oledzki <ole@ans.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug in "raid5: measuring checksumming speed"
Message-ID: <20011020141454.A7819@xs4all.nl>
In-Reply-To: <Pine.LNX.4.33.0110201342410.19999-100000@dark.pcgames.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0110201342410.19999-100000@dark.pcgames.pl>; from ole@ans.pl on Sat, Oct 20, 2001 at 01:54:54PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2001 at 01:54:54PM +0200, Krzysztof Oledzki wrote:
> Hello,
> 
> It seems that there is something wrong with measuring checksumming speed -
> on my two P3 boxes linux chooses pIII_sse but pII_mmx and p5_mmx are
> reported as faster instructions:
> 
I read somewhere that PIII_sse has better cache behaviour. You could
check this by reading the source, of course.

Good luck,
Jurriaan
