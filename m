Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbVFAPcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVFAPcv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 11:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVFAPcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 11:32:50 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:1503 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261423AbVFAPa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 11:30:26 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Wed, 01 Jun 2005 17:28:50 +0200
To: schilling@fokus.fraunhofer.de, jim@why.dont.jablowme.net
Cc: toon@hout.vanvergehaald.nl, mrmacman_g4@mac.com, ltd@cisco.com,
       linux-kernel@vger.kernel.org, dtor_core@ameritech.net, 7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Message-ID: <429DD432.nail7BF810RPU@burner>
References: <26A66BC731DAB741837AF6B2E29C10171E60DE@xmb-hkg-413.apac.cisco.com>
 <20050530093420.GB15347@hout.vanvergehaald.nl>
 <429B0683.nail5764GYTVC@burner>
 <46BE0C64-1246-4259-914B-379071712F01@mac.com>
 <429C4483.nail5X0215WJQ@burner> <20050531172204.GD17338@voodoo>
In-Reply-To: <20050531172204.GD17338@voodoo>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jim Crilly" <jim@why.dont.jablowme.net> wrote:

> On 05/31/05 01:03:31PM +0200, Joerg Schilling wrote:
> > 
> > > And why again do you need stable SCSI addresses for my _USB_ drive?
> > 
> > Well if the udev program was polite to users, it would also support
> > to edit /etc/default/cdrecord...... 
> > 
> > ... if it _really_ does wat you like with /dev/ links, then it has all 
> > the information that is needed to also maintain /etc/default/cdrecord
>
> The rules and scripts that udev uses to name things can do anything since
> it runs in userland, so udev could easily edit /etc/default/cdrecord if
> someone took the time to write the script.

If it has the knowledge and if it is able to run parameterized sed from 
internal rules, it should be possible to configure udev to 
modify /etc/default/cdrecord, but as I don't have such a system, it would
be nice if this was done by someone else.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  
       schilling@fokus.fraunhofer.de	(work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
