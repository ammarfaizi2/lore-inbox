Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261828AbSI2V7M>; Sun, 29 Sep 2002 17:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261830AbSI2V7L>; Sun, 29 Sep 2002 17:59:11 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:49412 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S261828AbSI2V7L>; Sun, 29 Sep 2002 17:59:11 -0400
Date: Mon, 30 Sep 2002 00:04:21 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: GrandMasterLee <masterlee@digitalroadkill.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: LVM in 2.5.39 broken.
Message-ID: <20020929220421.GI12928@merlin.emma.line.org>
Mail-Followup-To: GrandMasterLee <masterlee@digitalroadkill.net>,
	linux-kernel@vger.kernel.org
References: <1033318471.2451.17.camel@UberGeek.digitalroadkill.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033318471.2451.17.camel@UberGeek.digitalroadkill.net>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Sep 2002, GrandMasterLee wrote:

> LVM compilation in 2.5.39 seems to be broken. 

LVM1 has not been adjusted to track the API changes in 2.5. Technical as
that may sound: LVM1 is broken in 2.5 and will probably never be fixed,
but replaced by something else. Peek into the 2.6/3.0 tree that's in
progress at this moment to see how things are going.

-- 
Matthias Andree
