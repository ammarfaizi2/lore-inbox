Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267442AbTAVMGv>; Wed, 22 Jan 2003 07:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267441AbTAVMGu>; Wed, 22 Jan 2003 07:06:50 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:20172 "EHLO
	crisis.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S267442AbTAVMGu>; Wed, 22 Jan 2003 07:06:50 -0500
To: Andries.Brouwer@cwi.nl
Cc: ALESSANDRO.SUARDI@oracle.com, efault@gmx.de, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: 3c509.c
References: <UTC200301221110.h0MBAHL28375.aeb@smtp.cwi.nl>
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 22 Jan 2003 13:13:23 +0100
Message-ID: <wrpiswhidr0.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <UTC200301221110.h0MBAHL28375.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andries" == Andries Brouwer <Andries.Brouwer@cwi.nl> writes:

Andries> I forgot to mention the conclusion of (3): inserting code
Andries> in the Boomerang driver to print ethN and MAC address
Andries> made immediately clear what happened: eth0 and eth1 had
Andries> been interchanged.

That's also an effect of the Space.c removal...
This is a lot more tricky to solve, apart from using modules.

        M.
-- 
Places change, faces change. Life is so very strange.
