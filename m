Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269407AbRH3O4l>; Thu, 30 Aug 2001 10:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272245AbRH3O4b>; Thu, 30 Aug 2001 10:56:31 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:36800 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S269407AbRH3O4N>;
	Thu, 30 Aug 2001 10:56:13 -0400
Date: Thu, 30 Aug 2001 12:47:00 +0200
From: Stefan Fleiter <stefan.fleiter@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Diet /sbin/hotplug package released
Message-ID: <20010830124700.A3694@shuttle.mothership.home.dhs.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010829120440.B12825@kroah.com> <20010829221246.B30945@vitelus.com> <20010829222206.B14791@kroah.com> <20010829222726.C30945@vitelus.com> <20010829222731.A14937@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20010829222731.A14937@kroah.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg!

On Wed, 29 Aug 2001 Greg KH wrote:

> I realize that not all /bin/sh is really bash, that's why the scripts
> explicitly ask for bash.  I'm guessing some bashisms are in there :)

Does it really make any sense to optimize for size and at the same time
force the user to install a bash compatible shell?

Stefan
