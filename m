Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267418AbTAHQYm>; Wed, 8 Jan 2003 11:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267823AbTAHQYm>; Wed, 8 Jan 2003 11:24:42 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:28393 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267418AbTAHQYk>; Wed, 8 Jan 2003 11:24:40 -0500
Reply-to: Wolfgang Fritz <wolfgang.fritz@gmx.net>
To: linux-kernel@vger.kernel.org
From: Wolfgang Fritz <wolfgang.fritz@gmx.net>
Subject: Re: [Asterisk] DTMF noise
Date: Wed, 08 Jan 2003 17:30:54 +0100
Organization: None
Message-ID: <3E1C523E.5050105@gmx.net>
References: <D6889804-2291-11D7-901B-000393950CC2@karlsbakk.net> <3E1BD88A.4080808@users.sf.net> <3E1C1CDE.8090600@sktc.net> <3E1C4872.7080508@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020610
X-Accept-Language: en-us, en, de-de, de
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.7; AVE: 6.17.0.2; VDF: 6.17.0.12; host: gurke)
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.7; AVE: 6.17.0.2; VDF: 6.17.0.12; host: gurke)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfgang Fritz wrote:

[cut]

> 
> There exists a long text about DTMF detection somewhere on the net (I 
> may have the link in the office but I'm on vacation now). What I 
> remember is that a "correct" DTMF detection requires much more computing 
> power as the present i4l implementation needs (much longer audio samples 
> for the goertzel filter, a larger number of frequencies to check) and a 
> standard test procedure with a lot of test cases which are not available 
> to mortal humans (audio tapes from Bellcore IIRC)
>

The link below is not the text I mean above but shows an approach which 
is similar to the present i4l implementation but has some improvements 
which may be good enough for us.

http://www.mitsubishichips.com/press/dtmf0199e.pdf

> Wolfgang
>  >
[cut]




