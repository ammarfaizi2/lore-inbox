Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262980AbSJBGPK>; Wed, 2 Oct 2002 02:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262981AbSJBGPK>; Wed, 2 Oct 2002 02:15:10 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:62712 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262980AbSJBGPJ>; Wed, 2 Oct 2002 02:15:09 -0400
Message-ID: <3D9A9015.2090503@us.ibm.com>
Date: Tue, 01 Oct 2002 23:20:05 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Dennis_Bj=F6rklund?= <db@zigo.dhs.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: input layer - activate keyboard
References: <Pine.LNX.4.44.0210020734480.10497-100000@zigo.dhs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dennis Björklund wrote:
> I have an IBM Rapid Access keyboard that needs to be sent an activation
> code to activate the multimedia keys at startup. Is there support for
> this? I would not be surprised if there where other input devices who also
> needs commands sent to them.

I have an "IBM Rapidaccess II" keyboard with a few miscellaneous keys 
in the top and center, with a few more CD-player type controls in the 
upper left.  You don't need an "activation code", just something to 
handle its funny scancodes.  I use hotkeys to manage it.  There's a 
Debian package for it:
http://packages.debian.org/unstable/x11/hotkeys.html

-- 
Dave Hansen
haveblue@us.ibm.com

