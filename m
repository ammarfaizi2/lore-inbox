Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264655AbTFCI07 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 04:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264688AbTFCI07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 04:26:59 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:23261 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S264655AbTFCI05 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 04:26:57 -0400
Message-ID: <D9B4591FDBACD411B01E00508BB33C1B014052A4@mesadm.epl.prov-liege.be>
From: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
To: linux-kernel@vger.kernel.org
Subject: RE: Weird keyboard with 2.4.20 (NEW!)
Date: Tue, 3 Jun 2003 10:26:42 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !
	In the same thread : slight trouble with 2.5.70 / 2.4.19
Using 2.5.70 -> no problem
I've got to reboot twice to switch back to 2.4.19 or I loose my keyboard...

Regards,
Fabian

-----Message d'origine-----
De : Catalin BOIE [mailto:util@deuroconsult.ro]
Envoyé : mardi 3 juin 2003 10:31
À : linux-kernel@vger.kernel.org
Objet : Weird keyboard with 2.4.20 (NEW!)


Hi!

I saw a problem with the keyboard and I want to tell my story.
Motherboards are EPOX with an Nvidia TNT2 card.
2 computers - not the same hard configuration.
>From time to time the keyboard goes crazy: I press A it gives me z, I
press ENTER it gives me n and so on.
After a while or with a reset, the problem is gone.
What can this be?
Thanks!


On Mon, 2 Jun 2003, Wiktor Wodecki wrote:

> On Mon, Jun 02, 2003 at 09:11:49AM -0700, Andy Pfiffer wrote:
> > On Sat, 2003-05-31 at 08:16, Konstantin Kletschke wrote:
> >
> > > Sometime a key is very fast repeated 10 to 20 times after pressed only
> > > one.
> >
> > I have seen this on one of two systems connected to a 4-port KVM
> > switch.  I started seeing it in 2.5.68 or 2.5.69.  The other system has
> > not demonstrated the super-fast repeat.
>
> I see this on my ibm thinkpad T20 with 2.5.69. I manually raised my
> kbdrate(1) settings and that helps. However when switching between X
> and text-consoles it gets worse after a while.
>
> --
> Regards,
>
> Wiktor Wodecki
>

---
Catalin(ux) BOIE
catab@deuroconsult.ro
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
