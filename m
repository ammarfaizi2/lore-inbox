Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317101AbSHGF3F>; Wed, 7 Aug 2002 01:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317107AbSHGF3F>; Wed, 7 Aug 2002 01:29:05 -0400
Received: from mail.gurulabs.com ([208.177.141.7]:7099 "HELO mail.gurulabs.com")
	by vger.kernel.org with SMTP id <S317101AbSHGF3E>;
	Wed, 7 Aug 2002 01:29:04 -0400
Date: Tue, 6 Aug 2002 23:32:42 -0600 (MDT)
From: Dax Kelson <dax@gurulabs.com>
X-X-Sender: dkelson@mooru.gurulabs.com
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ethtool documentation
In-Reply-To: <Pine.LNX.3.95.1020806151104.25149A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44.0208062318350.4696-100000@mooru.gurulabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug 2002, Richard B. Johnson wrote:

> If you let a user write to this area, you will allow the user
> to destroy the connectivity on a LAN.
> 
> Because of this, there is no such thing as 'unused eeprom space' in
> the Ethernet Controllers. Be careful about putting this weapon in
> the hands of the 'public'. All you need is for one Linux Machine
> on a LAN to end up with the same IEEE Station Address as another
> on that LAN and connectivity to everything on that segment will
> stop. You do this once at an important site and Linux will get a
> very black eye.

Dick, this "weapon" has been the in the hands of admins and evil-doers for 
YEARS!

It is called /sbin/ifconfig

With this evil command nearly any NIC can masquerade as any one of
~281474976710656 possible IEEE Station Addresses. This weapon of
destruction has seen wide spread proliferation across most Unix varients.
Human sacrifice, dogs and cats living together, mass hysteria!

Err, no wait.

The sky is not falling, you protest too much.

Dax Kelson

