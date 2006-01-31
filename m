Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWAaNRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWAaNRf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 08:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWAaNRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 08:17:35 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:59609 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1750806AbWAaNRe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 08:17:34 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Oliver Neukum <oliver@neukum.org>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Tue, 31 Jan 2006 14:44:47 +0200
User-Agent: KMail/1.8.2
Cc: jerome lacoste <jerome.lacoste@gmail.com>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>, j@bitron.ch,
       mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jengelh@linux01.gwdg.de,
       James@superbug.co.uk, acahalan@gmail.com
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com> <5a2cf1f60601310424w6a64c865u590652fbda581b06@mail.gmail.com> <200601311333.36000.oliver@neukum.org>
In-Reply-To: <200601311333.36000.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601311444.47199.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 January 2006 14:33, Oliver Neukum wrote:
> Am Dienstag, 31. Januar 2006 13:24 schrieb jerome lacoste:
> > On 1/31/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> > > Jürg Billeter <j@bitron.ch> wrote:
> > [...]
> > > Users like to be able to get a list of posible targets for a single protocol.
> > 
> > The Linux users (I know of) like to be able to reference their drives
> > the way their Operating System names them.
> > 
> > If it's /dev/cdrw, then it's /dev/cdrw, not '1,0,0'.
> > 
> > Should we make a poll ?
> 
> It is entirely possible that the people you know are far from a representative
> sample. Most people likely prefer clicking on a description in a GUI. There
> needs to be a way to get this list and if possible it should not be specific
> to Linux.

Do we need to expose IDE master/slave, primary/secondary concepts in Linux?

So far I was perfectly happy with just /dev/hd[a-z][0-9]*
--
vda
