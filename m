Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbWEHP1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbWEHP1E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 11:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWEHP1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 11:27:03 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:37733 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932387AbWEHP1B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 11:27:01 -0400
Date: Mon, 8 May 2006 17:27:00 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Madhukar Mythri <madhukar.mythri@wipro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to read BIOS information
Message-ID: <20060508152659.GG1875@harddisk-recovery.com>
References: <445F5228.7060006@wipro.com> <1147099994.2888.32.camel@laptopd505.fenrus.org> <445F5DF1.3020606@wipro.com> <1147101329.2888.39.camel@laptopd505.fenrus.org> <445F63B3.2010501@wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <445F63B3.2010501@wipro.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2006 at 08:58:51PM +0530, Madhukar Mythri wrote:
> I forgot mention, that my Kernel is NONSMP based kernel....

Then your application can't use HT anyway, so why bother?


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
