Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312560AbSIDRsd>; Wed, 4 Sep 2002 13:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312558AbSIDRsd>; Wed, 4 Sep 2002 13:48:33 -0400
Received: from rom.cscaper.com ([216.19.195.129]:37036 "HELO mail.cscaper.com")
	by vger.kernel.org with SMTP id <S311749AbSIDRsc>;
	Wed, 4 Sep 2002 13:48:32 -0400
Subject: Re: IDE-DVD problems [excuse former idiotic topic]
Content-Transfer-Encoding: 7BIT
To: Benjamin LaHaise <bcrl@redhat.com>
From: "Joseph N. Hall" <joseph@5sigma.com>
Cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Wed, 4 Sep 2002 10:54 -0700
X-mailer: Mailer from Hell v1.0
Message-Id: <20020904174832Z311749-685+42783@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using 2.4.20-pre5-ac1 and the latest ALSA.

Would it be worthwhile to try a dev kernel?  I really dislike
the ALSA building process.  Is RH7.3 ok with the latest
2.5 kernel?

  -joseph

On Wed, 4 Sep 2002 13:44:07 -0400, Benjamin LaHaise <bcrl@redhat.com> wrote:
>> You might need to upgrade from the -3 kernel (several errata have 
> been released) as there were a few known problems with some network 
> drivers, as well as NFS and ext3.  Different drives also have varing 
> amounts of cache, and it might be this that you're noticing.
> 
> > I am also having problems with the C-Media onboard audio +
> > ALSA (0.9 rc3) ... it hangs the system (totally) after playing
> > for a few seconds.  So that is another strike against this
> > particular h/w configuration.
> 
> Again, try a newer kernel.  I'm using a C-Media at home and it works 
> pretty well for ogg/DVD playback.

