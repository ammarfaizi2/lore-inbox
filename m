Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274671AbRIYWqt>; Tue, 25 Sep 2001 18:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274674AbRIYWqi>; Tue, 25 Sep 2001 18:46:38 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:19983 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S274670AbRIYWqa> convert rfc822-to-8bit; Tue, 25 Sep 2001 18:46:30 -0400
Date: Tue, 25 Sep 2001 18:23:40 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Juan <piernas@ditec.um.es>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Bad, bad, bad VM behaviour in 2.4.10
In-Reply-To: <3BB1005C.5C13A53F@ditec.um.es>
Message-ID: <Pine.LNX.4.21.0109251823020.2193-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 26 Sep 2001, Juan wrote:

> Marcelo Tosatti escribió:
> > 
> > Juan,
> > 
> > It is a known problem which we are looking into.
> > 
> > I need some information which may help confirm a guess of mine:
> > 
> > Do you have swap available ?
> Yes, the /dev/hda6 partition, that is 257000 KB in size.
> 
> > 
> > If so, there was available anonymous memory to be swapped out ?
> 
> Anonymous memory? Sorry, but I do not understand this question. Could
> you redo it?

By anynomymous memory I mean memory which is not disk cache (ie is not
data which is going to be written to the filesystem): Program data. 

