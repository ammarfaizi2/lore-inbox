Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316636AbSFZPW1>; Wed, 26 Jun 2002 11:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316637AbSFZPW0>; Wed, 26 Jun 2002 11:22:26 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:20997 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316636AbSFZPWS>;
	Wed, 26 Jun 2002 11:22:18 -0400
Date: Wed, 26 Jun 2002 08:22:13 -0700
From: Greg KH <greg@kroah.com>
To: Marek Michalkiewicz <marekm@amelek.gda.pl>
Cc: marcelo@conectiva.com.br, mdharm-usb@one-eyed-alien.net, mwilck@freenet.de,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] USB storage: Datafab KECF-USB, Sagatek DCS-CF
Message-ID: <20020626152213.GE4611@kroah.com>
References: <20020626145741.GD4611@kroah.com> <E17NEUr-0005sx-00@alf.amelek.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17NEUr-0005sx-00@alf.amelek.gda.pl>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 29 May 2002 13:38:28 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2002 at 05:14:17PM +0200, Marek Michalkiewicz wrote:
> > Heh, send this to me again after 2.4.19-final is out, and I'll
> > reconsider it :)
> 
> Do you see any potential problems with the patch, or is 2.4.19-final
> now simply so close that you really don't want to change anything?

2.4.19-final is too close.  I'll trust Matt to tell me if the patch is
ok or not technically, as it's his code.  I'd also prefer for you to
work through him, as he is the maintainer, and not try to send things
like this to Marcelo directly (read Documentation/SubmittingPatches).

thanks,

greg k-h
