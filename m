Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283302AbRK2QTA>; Thu, 29 Nov 2001 11:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283306AbRK2QSw>; Thu, 29 Nov 2001 11:18:52 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:13987 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S283302AbRK2QSi>; Thu, 29 Nov 2001 11:18:38 -0500
Date: Thu, 29 Nov 2001 18:18:17 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: =?iso-8859-1?Q?Peter_W=E4chtler?= <pwaechtler@loewe-komp.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: e2compr on 2.4
Message-ID: <20011129181817.A31769@niksula.cs.hut.fi>
In-Reply-To: <3C0656A4.93D3B1F5@loewe-komp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C0656A4.93D3B1F5@loewe-komp.de>; from pwaechtler@loewe-komp.de on Thu, Nov 29, 2001 at 04:39:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2001 at 04:39:16PM +0100, you [Peter Wächtler] claimed:
> Hi,
> 
> browsing through the archives I read a discussion in February 2000
> about e2compr and integrating it into 2.3^H4
> 
> Is anyone working on it or willing to help?

Well, at early 2.3 times, Riley Williams announced he'd be willing
to take the maintainership as Peter Moulder (who did good job btw) 
had said he had no more time to do it. There was talk about porting it
to 2.3:

http://marc.theaimsgroup.com/?l=linux-kernel&m=94985828506070&w=2
                                                                                
Then on October, Pierre Peiffer asked for directorions to port e2compr to        
2.4, and people like Eric Biederman replied. See: 

http://marc.theaimsgroup.com/?l=linux-kernel&m=100209862820677&w=2

(I have stared at the code long enough to know I'm not up to the task        
(that was when I tracked down a lock up bug that happened with samba, and       
Peter later fixed.) ;)

That said, it would be cool if e2compr would be ported to 2.[45].


-- v --

v@iki.fi
