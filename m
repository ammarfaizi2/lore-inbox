Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263046AbTCSPTF>; Wed, 19 Mar 2003 10:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263050AbTCSPTF>; Wed, 19 Mar 2003 10:19:05 -0500
Received: from dhcpvisitor217225.slac.stanford.edu ([198.129.217.225]:59280
	"EHLO localhost.sgowdy.org") by vger.kernel.org with ESMTP
	id <S263046AbTCSPTE>; Wed, 19 Mar 2003 10:19:04 -0500
Date: Wed, 19 Mar 2003 07:28:47 -0800 (PST)
From: "Stephen J. Gowdy" <gowdy@slac.stanford.edu>
X-X-Sender: gowdy@localhost.localdomain
Reply-To: gowdy@slac.stanford.edu
To: Andrey Panin <pazke@orbita1.ru>
cc: linux-kernel@vger.kernel.org, <linux-usb-users@lists.sourceforge.net>
Subject: Re: [Linux-usb-users] USB harddrive not working (2.4, 2.5)
In-Reply-To: <20030319102117.GA689@pazke>
Message-ID: <Pine.LNX.4.44.0303190727360.2052-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44.0303190727362.2052@localhost.localdomain>
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The error "USB device not accepting new address" can sometimes be a 
symptom of an interrupt problem. Do you see interrupts increasing for this 
device in /proc/interrupts? There is some more info on this in the FAQ at 
http://www.linux-usb.org .

On Wed, 19 Mar 2003, Andrey Panin wrote:

> Hi,
> 
> ISD200 based hard drive bay doesn't work with 2.4 & 2.5, 
> can someone assist me with it?
> 
> Kernel message log appended.
> 
> Best regards.
> 
> 

-- 
 /------------------------------------+-------------------------\
|Stephen J. Gowdy                     | SLAC, MailStop 34,       |
|http://www.slac.stanford.edu/~gowdy/ | 2575 Sand Hill Road,     |
|http://calendar.yahoo.com/gowdy      | Menlo Park CA 94025, USA |
|EMail: gowdy@slac.stanford.edu       | Tel: +1 650 926 3144     |
 \------------------------------------+-------------------------/

