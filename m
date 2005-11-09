Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161251AbVKIVx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161251AbVKIVx0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 16:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161252AbVKIVxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 16:53:24 -0500
Received: from cantor2.suse.de ([195.135.220.15]:13253 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161251AbVKIVxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 16:53:20 -0500
From: Andreas Schwab <schwab@suse.de>
To: thockin@hockin.org
Cc: linas <linas@austin.ibm.com>, Vadim Lobanov <vlobanov@speakeasy.net>,
       "J.A. Magallon" <jamagallon@able.es>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Douglas McNaught <doug@mcnaught.org>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       bluesmoke-devel@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz, linuxppc64-dev@ozlabs.org
Subject: Re: typedefs and structs
References: <B68D1F72-F433-4E94-B755-98808482809D@mac.com>
	<20051109003048.GK19593@austin.ibm.com>
	<m27jbihd1b.fsf@Douglas-McNaughts-Powerbook.local>
	<20051109004808.GM19593@austin.ibm.com>
	<19255C96-8B64-4615-A3A7-9E5A850DE398@mac.com>
	<20051109111640.757f399a@werewolf.auna.net>
	<Pine.LNX.4.58.0511090816300.4260@shell2.speakeasy.net>
	<20051109192028.GP19593@austin.ibm.com>
	<20051109193625.GA31889@hockin.org>
	<20051109193828.GR19593@austin.ibm.com>
	<20051109203954.GA3539@hockin.org>
X-Yow: With YOU, I can be MYSELF..  We don't NEED Dan Rather..
Date: Wed, 09 Nov 2005 22:53:13 +0100
In-Reply-To: <20051109203954.GA3539@hockin.org> (thockin@hockin.org's message
	of "Wed, 9 Nov 2005 12:39:54 -0800")
Message-ID: <jelkzxqyie.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thockin@hockin.org writes:

> Sigh, That's funny - I've written C++ code which has references as members
> of objects.  You absolutely *can* store a reference.

You can _initialize_, but not _modify_ (reseat) it.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
