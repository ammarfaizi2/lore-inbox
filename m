Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263353AbTDLSIz (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 14:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263354AbTDLSIz (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 14:08:55 -0400
Received: from mrw.demon.co.uk ([194.222.96.226]:15488 "EHLO rebecca")
	by vger.kernel.org with ESMTP id S263353AbTDLSIy convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 14:08:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Mark Watts <m.watts@mrw.demon.co.uk>
To: Frank Van Damme <frank.vandamme@student.kuleuven.ac.be>
Subject: Re: stabilty problems using opengl on kt400 based system
Date: Sat, 12 Apr 2003 19:20:38 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200304121410.58522.frank.vandamme@student.kuleuven.ac.be> <200304121608.33357.m.watts@mrw.demon.co.uk> <200304122010.52375.frank.vandamme@student.kuleuven.ac.be>
In-Reply-To: <200304122010.52375.frank.vandamme@student.kuleuven.ac.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304121920.38974.m.watts@mrw.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 Apr 2003 7:10 pm, Frank Van Damme wrote:
>
> I am not sure, but I though nVidia cards were different. I have used a tnt2
> before I had my radeon (I used it with that previous motherboard) and back
> then, I have been advised to compile kernels without AGP support since the
> nVidia drivers wouldn't use them anyway (despite the fact that it was a 4x
> agp card). NVidia seems to have his own method of accessing the agp bus.

I'm not entirely sure how I tell what agp gart I'm using, but I have 'agpgart' 
loaded as a module...

Mark.
