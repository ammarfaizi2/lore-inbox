Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310540AbSCLKGG>; Tue, 12 Mar 2002 05:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310544AbSCLKF6>; Tue, 12 Mar 2002 05:05:58 -0500
Received: from ns.ithnet.com ([217.64.64.10]:34565 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S310540AbSCLKFh>;
	Tue, 12 Mar 2002 05:05:37 -0500
Date: Tue, 12 Mar 2002 12:06:44 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre3
Message-Id: <20020312120644.1f111c09.skraw@ithnet.com>
In-Reply-To: <20020312015059.GA711@matchmail.com>
In-Reply-To: <Pine.LNX.4.21.0203111805480.2492-100000@freak.distro.conectiva>
	<200203112255.XAA02708@webserver.ithnet.com>
	<20020312015059.GA711@matchmail.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002 17:50:59 -0800
Mike Fedyk <mfedyk@matchmail.com> wrote:

> On Mon, Mar 11, 2002 at 11:55:23PM +0100, Stephan von Krawczynski wrote:
> > >                                                                     
> > > Hi,                                                                 
> > >                                                                     
> > > Here goes -pre3, with the new IDE code. It has been stable enough   
> > time in                                                               
> > > the -ac tree, in my and Alan's opinion.                             
> > >                                                                     
> > > The inclusion of the new IDE code makes me want to have a longer    
> > 2.4.19                                                                
> > > release cycle, for stress-testing reasons.                          
> > >                                                                     
> > > Please stress test it with huge amounts of data ;)                  
> >                                                                       
> > Would like to, but:                                                   
> >                                                                       
> > gcc -D__KERNEL__ -I/usr/src/linux-2.4.19-pre3/include -Wall           
> > [...]
> > make[2]: *** [pppoe.o] Error 1                                        
> > make[2]: Leaving directory `/usr/src/linux-2.4.19-pre3/drivers/net'   
> > make[1]: *** [_modsubdir_net] Error 2                                 
> > make[1]: Leaving directory `/usr/src/linux-2.4.19-pre3/drivers'       
> > make: *** [_mod_drivers] Error 2                                      
> 
> same here, with gcc 2.95.4 (debian -woody).
> 
> What is your compiler version (in case it's 3.x)?

gcc version 2.95.3 20010315 (SuSE)


