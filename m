Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262202AbREQWq4>; Thu, 17 May 2001 18:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262206AbREQWqq>; Thu, 17 May 2001 18:46:46 -0400
Received: from quattro.sventech.com ([205.252.248.110]:34566 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S262202AbREQWqh>; Thu, 17 May 2001 18:46:37 -0400
Date: Thu, 17 May 2001 18:46:36 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Kai Henningsen <kaih@khms.westfalen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010517184636.L32405@sventech.com>
In-Reply-To: <Pine.LNX.4.21.0105151208540.2339-100000@penguin.transmeta.com> <20010515145830.Y5599@sventech.com> <Pine.LNX.4.21.0105151208540.2339-100000@penguin.transmeta.com> <20010515154325.Z5599@sventech.com> <811ooI$Hw-B@khms.westfalen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <811ooI$Hw-B@khms.westfalen.de>; from Kai Henningsen on Thu, May 17, 2001 at 10:40:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2001, Kai Henningsen <kaih@khms.westfalen.de> wrote:
> johannes@erdfelt.com (Johannes Erdfelt)  wrote on 15.05.01 in <20010515154325.Z5599@sventech.com>:
> 
> > I had always made the assumption that sockets were created because you
> > couldn't easily map IPv4 semantics onto filesystems. It's unreasonable
> > to have a file for every possible IP address/port you can communicate
> > with.
> 
> Not at all. What is unreasonable is douing a "ls" on the directory in  
> question.
> 
> Big deal; make it mode d--x--x--x. Problem solved.
> 
> And I'm pretty certain stuff like that *has* been done - wasn't there a  
> ftp file system where you could "ls /mountpoint/ftp.kernel.org/pub/linux"?

I think this is the difference between reasonable and unreasonable.

I'm sure it could be done, but should it?

JE

