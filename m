Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267390AbTAVJXR>; Wed, 22 Jan 2003 04:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267392AbTAVJXR>; Wed, 22 Jan 2003 04:23:17 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:8652 "EHLO
	crisis.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S267390AbTAVJXR>; Wed, 22 Jan 2003 04:23:17 -0500
To: Andries.Brouwer@cwi.nl
Cc: jgarzik@pobox.com, ALESSANDRO.SUARDI@oracle.com, efault@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: 3c509.c
References: <UTC200301212045.h0LKjSp11532.aeb@smtp.cwi.nl>
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 22 Jan 2003 10:29:46 +0100
Message-ID: <wrp65shjzw5.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <UTC200301212045.h0LKjSp11532.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andries" == Andries Brouwer <Andries.Brouwer@cwi.nl> writes:

Andries> This evening the next attempt. Under 2.5.58 my ethernet cards
Andries> still work, under 2.5.59 eth0, a 3c509, fails.

I'm the guilty one for (1) and (2). These problems are coming from the
3c509 removal from Space.c.

I'll cook a patch latter today...

Thanks for the report.

        M.
-- 
Places change, faces change. Life is so very strange.
