Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314291AbSEBJN5>; Thu, 2 May 2002 05:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314292AbSEBJN4>; Thu, 2 May 2002 05:13:56 -0400
Received: from AMontpellier-201-1-4-206.abo.wanadoo.fr ([217.128.205.206]:2234
	"EHLO awak") by vger.kernel.org with ESMTP id <S314291AbSEBJN4> convert rfc822-to-8bit;
	Thu, 2 May 2002 05:13:56 -0400
Subject: Re: A CD with errors (scratches etc.) blocks the whole system while
	reading damadged files
From: Xavier Bestel <xavier.bestel@free.fr>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Stephen Samuel <samuel@bcgreen.com>, Mike Fedyk <mfedyk@matchmail.com>,
        Bill Davidsen <davidsen@tmr.com>, Andre Hedrick <andre@linux-ide.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0205021041550.25786-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.3 
Date: 02 May 2002 11:12:14 +0200
Message-Id: <1020330736.2734.12.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu 02/05/2002 à 10:43, Zwane Mwaikambo a écrit :
> On 2 May 2002, Xavier Bestel wrote:
> 
> > The "system grinding to a halt" happens to me too, when *ripping*
> > scratched cds. Note that it's when using *userspace* access to the block
> > device, with e.g. cdparanoia or grip (or dvd ripping tools).
> 
> What does your system time usage look like?

IIRC (don't have a scratched cd at hand) nearly 100% system time (nearly
50% in fact cause it's a dual-proc)

	Xav

