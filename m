Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264147AbUHWNPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbUHWNPX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 09:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264154AbUHWNPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 09:15:22 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:16274 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264147AbUHWNPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 09:15:17 -0400
Date: Mon, 23 Aug 2004 15:15:14 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040823131514.GB13661@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <2vj2b-8md-9@gated-at.bofh.it> <2vDtS-bq-19@gated-at.bofh.it> <E1ByXMd-00007M-4A@localhost> <412770EA.nail9DO11D18Y@burner> <412889FC.nail9MX1X3XW5@burner> <Pine.LNX.4.58.0408221450540.297@neptune.local> <m37jrr40zi.fsf@zoo.weinigel.se> <4128CAA2.nail9RG21R1OG@burner> <87wtzq275g.fsf@killer.ninja.frodoid.org> <4129D7C4.nailA9B114PTI@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4129D7C4.nailA9B114PTI@burner>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2004-08-23:

> Only if someone would chown the related /dev/* nodes to a user differen from 
> root there would be a difference.

...which actually happens a lot, with the devperm PAM junk that some,
particularly desktop/end-user oriented distros do, for instance SuSE
Linux twist device permissions. It is awful for shared computers in a
network.

-- 
Matthias Andree

NOTE YOU WILL NOT RECEIVE MY MAIL IF YOU'RE USING SPF!
Encrypted mail welcome: my GnuPG key ID is 0x052E7D95 (PGP/MIME preferred)
