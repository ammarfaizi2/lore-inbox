Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVCCERm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVCCERm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 23:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVCCEOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 23:14:32 -0500
Received: from gate.crashing.org ([63.228.1.57]:26579 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261343AbVCCEMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 23:12:46 -0500
Subject: Re: radeonfb blanks my monitor
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= "L. W. Meunier" <2@pervalidus.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0503022347070.311@darkstar.example.net>
References: <Pine.LNX.4.62.0503022347070.311@darkstar.example.net>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 03 Mar 2005 15:10:10 +1100
Message-Id: <1109823010.5610.161.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-02 at 23:51 -0300, Frédéric L. W. Meunier wrote:
> I just replaced my Matrox G400 with a Jetway Radeon 9600LE 
> (256Mb). If I run 'modprobe radeonfb', the monitor blanks out 
> and the power on light keeps flashing.
> 
> What may be wrong ? Using 2.6.11.

Do you have a way to capture the dmesg log produced ?

Also, does it work if radeonfb is built-in ?



