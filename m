Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263397AbTCNR4U>; Fri, 14 Mar 2003 12:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263402AbTCNR4U>; Fri, 14 Mar 2003 12:56:20 -0500
Received: from quechua.inka.de ([193.197.184.2]:61084 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S263397AbTCNR4T>;
	Fri, 14 Mar 2003 12:56:19 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
References: <szaka@sienet.hu> <200303122113.h2CLDSfR032057@pincoya.inf.utfsm.cl>
Organization: private Linux site, southern Germany
Date: Fri, 14 Mar 2003 19:01:39 +0100
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E18ttUx-00036U-00@bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> code is designed to be easily decoded forward, noone executes code going
> backwards. Finding out what starts at EIP is easy.

I remember reading once in a magazine that there exists an
undocumented/illegal instruction in the x86 which causes the IP to run
backwards, similar to setting the D flag.

Was an April 1st issue though ;-)

Olaf

