Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289288AbSBDXm0>; Mon, 4 Feb 2002 18:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289291AbSBDXmR>; Mon, 4 Feb 2002 18:42:17 -0500
Received: from dsl-213-023-038-180.arcor-ip.net ([213.23.38.180]:48023 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289288AbSBDXmG>;
	Mon, 4 Feb 2002 18:42:06 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Daniel Phillips <phillips@bonn-fries.net>
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
Date: Tue, 5 Feb 2002 00:46:44 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <E16XmqC-0007lb-00@the-village.bc.nu> <E16Xnn7-0004mp-00@starship.berlin> <a3n0ue$gat$1@cesium.transmeta.com>
In-Reply-To: <a3n0ue$gat$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <E16Xsou-0004o5-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 4, 2002 11:11 pm, H. Peter Anvin wrote:
> By author:    Daniel Phillips <phillips@bonn-fries.net>
> > Somebody said:
> > > It's silly to put it permanently in unswappable memory; putting it in 
> > > /lib/modules/`uname -r/ somewhere does make tons of sense instead.
> > 
> > Could you show me where I suggested putting it "permanently in unswappable memory"?
> 
> You suggested putting it in the kernel, which is permanently in
> unswappable memory.  Using a module is, as I pointed out earlier,
> worse than useless.

Is this what you you're referring to:

On February 4, 2002 07:22 pm, H. Peter Anvin wrote:
> Uhm, no.  The problem with it is that you're using kernel memory
> because you're not willing to manage userspace competently, so modules
> (in fact, *using modules at all*) would be right out.

I don't see your point.

/me points to where he said 'religious issue' above.

-- 
Daniel
