Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270228AbTHGPNl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 11:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270256AbTHGPMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 11:12:51 -0400
Received: from windsormachine.com ([206.48.122.28]:38062 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S270383AbTHGPLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 11:11:06 -0400
Date: Thu, 7 Aug 2003 11:10:59 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: Kathy Frazier <kfrazier@mdc-dayton.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [APM]  CPU idle calls causing problem with ASUS P4PE MoBo
In-Reply-To: <PMEMILJKPKGMMELCJCIGIEPOCDAA.kfrazier@mdc-dayton.com>
Message-ID: <Pine.LNX.4.56.0308071108110.18325@router.windsormachine.com>
References: <PMEMILJKPKGMMELCJCIGIEPOCDAA.kfrazier@mdc-dayton.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.12.3 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>

I'm curious why you are using the APM method.

Have you tried ACPI(which replaced APM a long time ago)

And also out of curiosity, have you played with the config_apm_allow_ints?

Mike
