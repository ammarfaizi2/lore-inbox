Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282771AbRLLWc4>; Wed, 12 Dec 2001 17:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282707AbRLLWcr>; Wed, 12 Dec 2001 17:32:47 -0500
Received: from ns.censoft.com ([208.219.23.2]:48339 "EHLO ns.censoft.com")
	by vger.kernel.org with ESMTP id <S282771AbRLLWch>;
	Wed, 12 Dec 2001 17:32:37 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jordan Crouse <jordanc@censoft.com>
Reply-To: jordanc@censoft.com
Organization: The Microwindows Project
To: "Herman Oosthuysen" <Herman@WirelessNetworksInc.com>,
        "Galappatti, Kishantha" <Kishantha.Galappatti@gs.com>,
        "'lkml'" <linux-kernel@vger.kernel.org>
Subject: Re: Bluetooth support on Linux
Date: Wed, 12 Dec 2001 15:28:37 -0700
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <D28C5BE01ECBD41198ED00D0B7E4C9DA08E1AF3A@gsny31e.ny.fw.gs.com> <000701c1835b$5cca29e0$0100007f@localdomain.wni.com.wirelessnetworksinc.com>
In-Reply-To: <000701c1835b$5cca29e0$0100007f@localdomain.wni.com.wirelessnetworksinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16EHvT-0004D1-00@ns.censoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ut a generic Bluetooth driver isn't something that can
> easily be included in the Kernel itself, since the modules are still
> evolving too rapidly.  

I disagree.  Between the Bluez and Affix projects, it is just as easy to 
write a new bluetooth driver as it is to write an new ethernet or sound 
driver.   I worked on a Bluetooth project recently (using the Bluez stack), 
and everything was very easy and it worked flawlessly (thanks to Maksim 
Krasnyanskiy and his team).
  
What's missing right now are the user land applications to make the bluetooth 
more useful.  The Windows world is replete with cute little programs that 
make sonar noises while they discover, and provide simple user interfaces for 
printing and whatever little else the Windows box allows.  While our 
functionality is all there, we have no auto discovery, and no easy way for 
users to get discovered and connected.

With a little effort in the user's direction, bluetooth could be a very 
useful thing.  And since Microsoft has chosen not to provide a bluetooth 
stack of their own (at least not in XP), Linux has the potential to be *the* 
OS when it comes to Bluetooth.  

Jordan

