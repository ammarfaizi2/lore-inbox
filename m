Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751746AbWBMKfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbWBMKfL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 05:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbWBMKfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 05:35:11 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:9633 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751746AbWBMKfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 05:35:07 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 13 Feb 2006 11:33:03 +0100
To: cfriesen@nortel.com, c.shoemaker@cox.net
Cc: tytso@mit.edu, schilling@fokus.fraunhofer.de, peter.read@gmail.com,
       mj@ucw.cz, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F0605F.nailKUS4BBBRF@burner>
References: <43EC887B.nailISDGC9CP5@burner>
 <mj+md-20060210.123726.23341.atrey@ucw.cz>
 <43EC8E18.nailISDJTQDBG@burner>
 <Pine.LNX.4.61.0602101409320.31246@yvahk01.tjqt.qr>
 <43EC93A2.nailJEB1AMIE6@burner> <20060210141651.GB18707@thunk.org>
 <43ECA3FC.nailJGC110XNX@burner> <43ECA70C.8050906@nortel.com>
 <43ECA8BC.nailJHD157VRM@burner> <43ECADA8.9030609@nortel.com>
 <20060210153223.GA27599@pe.Belkin>
In-Reply-To: <20060210153223.GA27599@pe.Belkin>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Shoemaker <c.shoemaker@cox.net> wrote:

> However, I don't think this is a reasonable interpretation, and it's
> clearly _not_ the one that Joerg is implying.
>
> Joerg is claiming that the quoted sentence also implies that
> _different_ st_ino/st_dev pairs will _always_ identify different
> files.  Taken in just the immediate context of stat.h, this is a
> very reasonable interpretation.

Correct, as a st_ino/st_dev pair uniquely identifies a file, the reverse
needs to be true in addition.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
