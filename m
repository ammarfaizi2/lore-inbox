Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315265AbSIDTaP>; Wed, 4 Sep 2002 15:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315276AbSIDTaO>; Wed, 4 Sep 2002 15:30:14 -0400
Received: from p50886EA2.dip.t-dialin.net ([80.136.110.162]:41351 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315265AbSIDTaL>; Wed, 4 Sep 2002 15:30:11 -0400
Date: Wed, 4 Sep 2002 13:34:25 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andries Brouwer <aebr@win.tue.nl>,
       James Bottomley <James.Bottomley@steeleye.com>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
Subject: Re: aic7xxx sets CDR offline, how to reset?
In-Reply-To: <20020904182505.B20614@bitwizard.nl>
Message-ID: <Pine.LNX.4.44.0209041333260.3373-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 4 Sep 2002, Rogier Wolff wrote:
> I will most likely set the "retry count" to 0: Never retry. Almost
> never works anyway. And the disk already retried manytimes, so
> retrying in software is only "taking time".

fd = open(pathname, O_NORETRY); ?

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

