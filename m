Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272735AbTG3FE0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 01:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272759AbTG3FE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 01:04:26 -0400
Received: from co239024-a.almel1.ov.home.nl ([217.120.226.100]:32898 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S272735AbTG3FEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 01:04:25 -0400
Date: Wed, 30 Jul 2003 07:02:30 +0200 (CEST)
From: Aschwin Marsman <a.marsman@aYniK.com>
X-X-Sender: marsman@localhost.localdomain
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre9
In-Reply-To: <Pine.LNX.4.53.0307292038450.11053@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.44.0307300657030.1807-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jul 2003, Zwane Mwaikambo wrote:

> On Tue, 29 Jul 2003, Marcelo Tosatti wrote:
> 
> > I know. I just forgot to add network driver fixes and b44 driver from
> > jgarziks tree. He sent me those _before_ I released -pre9. Thats why
> > -pre10 so soon.
> 
> Ok those would be easier to isolate problems with anyway.

In order to isolate problems, the fewer patches there are between releases,
the easier it will be to find out what can be the cause of the problem
(if any, the last couple of pre releases are working perfectly for me,
 if CONFIG_VIDEO_BT848 would be saved in .config, I can build them
 without human intervention, so the number of releases is no problem for
 me. When the compile succeeds, the next time I boot my machine I will have
 the latest kernel running, currently 2.4.22-pre9).
  
> > I think a one week average for pre releases is good.
> 
> Sounds fine, thanks.
> 
> 	Zwane
 
Have fun,
 
Aschwin Marsman
 
--
aYniK Software Solutions         all You need is Knowledge
P.O. box 134                     NL-7600 AC Almelo - the Netherlands
a.marsman@aYniK.com              http://www.aYniK.com

