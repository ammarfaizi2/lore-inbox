Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161409AbWASUpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161409AbWASUpv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 15:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161405AbWASUpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 15:45:51 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:8093 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1161409AbWASUpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 15:45:50 -0500
Subject: Re: RFC: OSS driver removal, a slightly different approach
From: Lee Revell <rlrevell@joe-job.com>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= "L. W. Meunier" <2@pervalidus.net>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0601191815550.1300@dyndns.pervalidus.net>
References: <20060119174600.GT19398@stusta.de>
	 <1137694944.32195.1.camel@mindpipe> <20060119182859.GW19398@stusta.de>
	 <1137695945.32195.7.camel@mindpipe> <20060119194432.GX19398@stusta.de>
	 <Pine.LNX.4.64.0601191815550.1300@dyndns.pervalidus.net>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 19 Jan 2006 15:45:48 -0500
Message-Id: <1137703548.32195.25.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-19 at 18:22 -0200, Frédéric L. W. Meunier wrote:
> On Thu, 19 Jan 2006, Adrian Bunk wrote:
> 
> > 3. no ALSA drivers for the same hardware
> 
> Why aren't drivers like SOUND_TVMIXER listed ? That one isn't 
> in ALSA, but there's a port at 
> http://www.gilfillan.org/v3tv/ALSA/ . It's now the only I 
> enable in OSS.
> 

Grr... why would someone bother to write a driver then not submit it or
even tell the ALSA maintainers?

Lee

