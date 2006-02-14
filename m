Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030464AbWBNFXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030464AbWBNFXv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030365AbWBNFXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:23:41 -0500
Received: from outgoing.tpinternet.pl ([193.110.120.20]:23206 "EHLO
	outgoing.tpinternet.pl") by vger.kernel.org with ESMTP
	id S1030460AbWBNFXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:23:06 -0500
In-Reply-To: <20060213120116.GA9294@merlin.emma.line.org>
References: <mj+md-20060210.123726.23341.atrey@ucw.cz> <43EC8E18.nailISDJTQDBG@burner> <Pine.LNX.4.61.0602101409320.31246@yvahk01.tjqt.qr> <43EC93A2.nailJEB1AMIE6@burner> <20060210141651.GB18707@thunk.org> <43ECA3FC.nailJGC110XNX@burner> <43ECA70C.8050906@nortel.com> <43ECA8BC.nailJHD157VRM@burner> <43ECADA8.9030609@nortel.com> <43F05FB2.nailKUS3MR1N9@burner> <20060213120116.GA9294@merlin.emma.line.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <40380EAF-68E7-47CE-BB50-6D3673392F33@neostrada.pl>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Marcin Dalecki <dalecki.marcin@neostrada.pl>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Tue, 14 Feb 2006 06:22:52 +0100
To: Matthias Andree <matthias.andree@gmx.de>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2006-02-13, at 13:01, Matthias Andree wrote:
>
> You're barking up the wrong tree anyways. You're holding on to a
> non-workable b,t,l approach because it's convenient on BSD and some
> other systems, but it cannot be stable. The only stable identifiers I
> conceive are brand,model,serial - and this is the way to get rid of  
> the
> ugly race between cdrecord -scanbus and cdrecord dev=b,t,l.

Right with the exception that it's the UID (unique id) *standard*  
that is
addressing this issue for other operating systems in a very reliable and
already successfull way. No need to invent something different here  
in particular
in the storage area.
