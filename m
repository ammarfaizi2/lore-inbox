Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318458AbSGaSzc>; Wed, 31 Jul 2002 14:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318459AbSGaSzc>; Wed, 31 Jul 2002 14:55:32 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:1800 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318458AbSGaSzb>;
	Wed, 31 Jul 2002 14:55:31 -0400
Date: Wed, 31 Jul 2002 11:57:26 -0700
From: Greg KH <greg@kroah.com>
To: Peter <pk@q-leap.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       johannes@erdfelt.com
Subject: Re: oops with usb-serial converter
Message-ID: <20020731185726.GB21972@kroah.com>
References: <S.0001006613@wolnet.de> <20020729173724.GA10153@kroah.com> <1027969112.4101.16.camel@irongate.swansea.linux.org.uk> <15688.12243.848371.562052@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15688.12243.848371.562052@gargle.gargle.HOWL>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 03 Jul 2002 17:52:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2002 at 08:43:31PM +0200, Peter wrote:
> 
> well, I use lvm, now I could try to compile without lvm support and
> boot into single user mode, and see if that works... or could you send
> me the function in question (maybe as a patch to 2.4.19-rc3?) - and if
> it works then, maybe the 2.4.19 final will include the patch?

Sorry, it's a big change, that will get backported to 2.4.20, but I
don't have the time to do it right now (and it's too late for 2.4.19
anyway.)  So I don't have a 2.4.19-rc3 patch.

Sorry,

greg k-h
