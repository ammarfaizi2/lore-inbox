Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263339AbTJKRO1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 13:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263335AbTJKRN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 13:13:59 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:10914 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S263334AbTJKRN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 13:13:56 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Problem with de4x5 on Alpha?
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
References: <20031011162651.GA25489@wang-fu.org>
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: Sat, 11 Oct 2003 19:12:08 +0200
Message-ID: <wrppth3snpz.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <20031011162651.GA25489@wang-fu.org> (Nathan Poznick's message
 of "Sat, 11 Oct 2003 11:26:51 -0500")
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Nathan" == Nathan Poznick <kraken@drunkmonkey.org> writes:

Nathan> I've been trying to get 2.6.0-test[6|7] to boot on my AS2100
Nathan> (Sable),

[...]

Could you please try 2.6.0-test5 ? Or even better, 2.6.0-test7 with
the 2.6.0-test5 driver (revert de4x5.[ch] and the Space.c changes) ?

The usual debug informations would be helpful too...

	M.
-- 
Places change, faces change. Life is so very strange.
