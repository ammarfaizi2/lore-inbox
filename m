Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbTFPIax (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 04:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263587AbTFPIax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 04:30:53 -0400
Received: from boden.synopsys.com ([204.176.20.19]:36065 "EHLO
	boden.synopsys.com") by vger.kernel.org with ESMTP id S263574AbTFPIaw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 04:30:52 -0400
Date: Mon, 16 Jun 2003 10:44:35 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: "Seifert Guido, gse" <Guido.Seifert@pentapharm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.5.71 cannot unmount nfs
Message-ID: <20030616084435.GH11885@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
Mail-Followup-To: "Seifert Guido, gse" <Guido.Seifert@pentapharm.com>,
	linux-kernel@vger.kernel.org
References: <0557B834CB410E4EB692BC78504D4C2C02F3EC@dc0011.pefade.pefa.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0557B834CB410E4EB692BC78504D4C2C02F3EC@dc0011.pefade.pefa.local>
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seifert Guido, gse, Mon, Jun 16, 2003 10:22:08 +0200:
> Sorry for the incomplete and unprofessional bugreport, I don't have more
> info. 
> I tried Kernel 2.5.71. Everything seems to work fine until I shut down
> or try to unmount a mountend nfs filesystem. For several minutes
> nothing happens, then I get something what looks like a backtrace from
> the nfs related code section. Unfortunately there is nothing in the
> log files afterwards. 

See the patch at http://bugme.osdl.org/show_bug.cgi?id=805


