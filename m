Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318407AbSGYKjk>; Thu, 25 Jul 2002 06:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318408AbSGYKjk>; Thu, 25 Jul 2002 06:39:40 -0400
Received: from [195.63.194.11] ([195.63.194.11]:35079 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S318407AbSGYKjk>; Thu, 25 Jul 2002 06:39:40 -0400
Message-ID: <3D3FD4E2.5070303@evision.ag>
Date: Thu, 25 Jul 2002 12:37:22 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: martin@dalecki.de, Vojtech Pavlik <vojtech@suse.cz>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/CFT] cmd640 irqlocking fixes
References: <20020724225826.GF25038@holomorphy.com>	<1027559111.6456.34.camel@irongate.swansea.linux.org.uk>	<20020725095448.B21541@ucw.cz> <3D3FB6C8.1070409@evision.ag>	<20020725105538.B21927@ucw.cz>  <3D3FBD21.2020607@evision.ag> <1027592641.9489.8.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Thu, 2002-07-25 at 09:56, Marcin Dalecki wrote:
> 
>>OK. Right. We have to touch this code anyway. Do you know first hand how
>>to detect programmatically which configuration method is in charge? If 
>>not I can look it up on my own..
> 
> 
> Just copy the code from 2.4.19-rc3-ac3. Andre didnt write it so you
> don't have to pretend it doesn't exist

Well...I *would* *not* mind patches from Andre.

Hell, I would take patches even from Saddam personally if they where
looking OK. And I look from time to time at the 2.4.xx tree. But I don't
look at the pre ac or whatever releases. Let them settle out
first :-) And last but not least most of the sorting out for particular 
host controller register tweaking is done by others not me...

 From Andre I only saw a single patch once a long long time ago
attached to full load of the usual personal insults.
It didn't even apply cleanly to the kernel tree it was supposed to apply 
too and it was "obviously" not correct as well.

Saddm, on the other side, apparently doesn't do Linux developement.
But Jamie Zawinski is still alive at least :-).

