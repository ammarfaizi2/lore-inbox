Return-Path: <linux-kernel-owner+w=401wt.eu-S932622AbWLZOSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbWLZOSW (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 09:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbWLZOSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 09:18:22 -0500
Received: from ara.aytolacoruna.es ([195.55.102.196]:39998 "EHLO
	mx.aytolacoruna.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932622AbWLZOSV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 09:18:21 -0500
Date: Tue, 26 Dec 2006 15:18:17 +0100
From: Santiago Garcia Mantinan <manty@manty.net>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: "Christopher S. Aker" <caker@theshore.net>,
       Patrick McHardy <kaber@trash.net>, linux-kernel@vger.kernel.org,
       ebtables-devel@lists.sourceforge.net
Subject: Re: ebtables problems on 2.6.19.1 *and* 2.6.16.36
Message-ID: <20061226141816.GA21165@clandestino.aytolacoruna.es>
References: <200612252344_MC3-1-D65C-20B2@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200612252344_MC3-1-D65C-20B2@compuserve.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for not replying before but I could not do any tests before today as
I didn't have access to any of the machines.

> Bingo!

Yes, I can confirm that your patch solves the problem, at least on my test
cases.

Thanks for your help!

Regards...
-- 
Santiago García Mantiñán
