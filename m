Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275530AbRJFTKC>; Sat, 6 Oct 2001 15:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275520AbRJFTJw>; Sat, 6 Oct 2001 15:09:52 -0400
Received: from mccammon.ucsd.edu ([132.239.16.211]:28117 "EHLO
	mccammon.ucsd.edu") by vger.kernel.org with ESMTP
	id <S275546AbRJFTJi>; Sat, 6 Oct 2001 15:09:38 -0400
Date: Sat, 6 Oct 2001 12:09:59 -0700 (PDT)
From: Alexei Podtelezhnikov <apodtele@mccammon.ucsd.edu>
X-X-Sender: <apodtele@chemcca18.ucsd.edu>
To: <chris@scary.beasts.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: VM: 2.4.10ac4 vs. 2.4.11pre2
Message-ID: <Pine.LNX.4.33.0110061141030.2549-100000@chemcca18.ucsd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris, 

Can you elaborate on "all over the place" by posting standard deviations 
of your measurements, or the entire sets? I guess you did about 6-10 of 
each. I think it's important since - who cares about good average 
performance if once in a while VM fails miserably. 

To emphasize the importance of this: I would expect that large deviations 
are more likely during short spikes of activity. It would be interesting 
to see how start-up times of mozilla vary having your linear swap 
test on the background. Too much to ask anyway.

Your conclusion about poor swapping with ac kernels is consistent with 
earlier posts ("VM: more numbers").

Alexei

