Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbVA2UgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVA2UgT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 15:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVA2UgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 15:36:18 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:23229 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261557AbVA2UgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 15:36:09 -0500
Subject: Re: OpenOffice crashes due to incorrect access permissions on
	/dev/dri/card*
From: Lee Revell <rlrevell@joe-job.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: ee21rh@surrey.ac.uk, linux-kernel@vger.kernel.org
In-Reply-To: <9e473391050129112525f4947@mail.gmail.com>
References: <pan.2005.01.29.10.44.08.856000@surrey.ac.uk>
	 <E1CurmR-0000H8-00@calista.eckenfels.6bone.ka-ip.net>
	 <pan.2005.01.29.12.49.13.177016@surrey.ac.uk>
	 <pan.2005.01.29.13.02.51.478976@surrey.ac.uk>
	 <9e473391050129112525f4947@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 29 Jan 2005 15:36:06 -0500
Message-Id: <1107030966.24676.28.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-01-29 at 14:25 -0500, Jon Smirl wrote:
>  
> > And oowriter and glxgears work from bootup. Shall I file a bug with udev?
> 
> Your user ID needs to belong to group DRI.
> 

Stupid question: what the heck does OO use DRI for?  I googled and came
up empty.

Lee

