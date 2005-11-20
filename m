Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbVKTCf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbVKTCf4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 21:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbVKTCf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 21:35:56 -0500
Received: from [205.233.219.253] ([205.233.219.253]:39126 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S1750816AbVKTCf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 21:35:56 -0500
Date: Sat, 19 Nov 2005 21:30:04 -0500
From: Jody McIntyre <scjody@steamballoon.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: bcollins@debian.org, linux1394-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/ieee1394/ieee1394_transactions.c should #include "ieee1394_transactions.h"
Message-ID: <20051120023004.GM4940@conscoop.ottawa.on.ca>
References: <20051119075420.GB16060@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051119075420.GB16060@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2005 at 08:54:20AM +0100, Adrian Bunk wrote:
> Every file should #include the headers containing the prototypes for 
> it's global functions.

Applied.

Cheers,
Jody
