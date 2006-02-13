Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWBMMOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWBMMOn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 07:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbWBMMOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 07:14:43 -0500
Received: from smtp10.wanadoo.fr ([193.252.22.21]:54227 "EHLO
	smtp10.wanadoo.fr") by vger.kernel.org with ESMTP id S932388AbWBMMOm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 07:14:42 -0500
X-ME-UUID: 20060213121441466.71EE62400153@mwinf1004.wanadoo.fr
Subject: vold for linux ? [was: Re: CD writing in future Linux (stirring up
	a hornets' nest)]
From: Xavier Bestel <xavier.bestel@free.fr>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: cfriesen@nortel.com, tytso@mit.edu, peter.read@gmail.com, mj@ucw.cz,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de
In-Reply-To: <43F05FB2.nailKUS3MR1N9@burner>
References: <Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr>
	 <43EB7BBA.nailIFG412CGY@burner> <mj+md-20060209.173519.1949.atrey@ucw.cz>
	 <43EC71FB.nailISD31LRCB@burner>
	 <20060210114721.GB20093@merlin.emma.line.org>
	 <43EC887B.nailISDGC9CP5@burner> <mj+md-20060210.123726.23341.atrey@ucw.cz>
	 <43EC8E18.nailISDJTQDBG@burner>
	 <Pine.LNX.4.61.0602101409320.31246@yvahk01.tjqt.qr>
	 <43EC93A2.nailJEB1AMIE6@burner> <20060210141651.GB18707@thunk.org>
	 <43ECA3FC.nailJGC110XNX@burner> <43ECA70C.8050906@nortel.com>
	 <43ECA8BC.nailJHD157VRM@burner> <43ECADA8.9030609@nortel.com>
	 <43F05FB2.nailKUS3MR1N9@burner>
Content-Type: text/plain
Message-Id: <1139832867.3527.140.camel@capoeira>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Mon, 13 Feb 2006 13:14:27 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-13 at 11:30, Joerg Schilling wrote:

> This media is mounted via a vold service and someone removes the USB cable
> and reinserts it a second later. The filesystem on the device will be mounted
> on the same mount point but the device ID inside the system did change.

BTW, is there a vold-like implementation for linux somewhere ?

Thanks,
	Xav


