Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314468AbSE2FiE>; Wed, 29 May 2002 01:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314483AbSE2FiD>; Wed, 29 May 2002 01:38:03 -0400
Received: from gate.in-addr.de ([212.8.193.158]:48905 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S314468AbSE2FiC>;
	Wed, 29 May 2002 01:38:02 -0400
Date: Wed, 29 May 2002 07:37:33 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre9
Message-ID: <20020529053732.GH6521@marowsky-bree.de>
In-Reply-To: <Pine.LNX.4.21.0205281905260.7798-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.99i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-05-28T19:06:42,
   Marcelo Tosatti <marcelo@conectiva.com.br> said:

Good morning Marcelo, could you please also consider switching to the somewhat
more dense format used by Linus recently? It makes the changelogs a lot more
readable.

As a further comment:

> <greg@kroah.com> (02/05/03 1.408)
> 	USB io_edgeport driver
> 
> <davem@nuts.ninka.net> (02/05/06 1.383.11.22)
> 	soft-fp fix:
>
> <colin@gibbs.dhs.org> (02/05/07 1.383.11.23)
> 	copy_mm fix:

and alike aren't actually very useful one-line summaries of the patch in
question to a "casual" reader, sorry.

In the first case, I can guess that probably, it is a new driver added; or
maybe it is just an update to an existing one? In the later two, what is
fixed? How does it affect my own code, or my running system?

The good work by all contributors not withstanding, it would be very nice if
they could make the summary slightly more useful before sending a patch to
Marcelo, for which I would like to thank everyone in advance ;-)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Immortality is an adequate definition of high availability for me.
	--- Gregory F. Pfister

