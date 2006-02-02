Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWBBVts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWBBVts (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 16:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWBBVts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 16:49:48 -0500
Received: from hummeroutlaws.com ([12.161.0.3]:3340 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S932311AbWBBVtq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 16:49:46 -0500
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Thu, 2 Feb 2006 16:49:39 -0500
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Albert Cahalan <acahalan@gmail.com>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>, mrmacman_g4@mac.com,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       James@superbug.co.uk, j@bitron.ch
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060202214938.GF10352@voodoo>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Albert Cahalan <acahalan@gmail.com>,
	Joerg Schilling <schilling@fokus.fraunhofer.de>, mrmacman_g4@mac.com,
	matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
	James@superbug.co.uk, j@bitron.ch
References: <43DF3C3A.nail2RF112LAB@burner> <1138710764.17338.47.camel@juerg-t40p.bitron.ch> <43DF6812.nail3B44TLQOP@burner> <20060202062840.GI5501@mail> <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo> <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com> <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr> <20060202210949.GD10352@voodoo> <1138915551.15691.123.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138915551.15691.123.camel@mindpipe>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/06 04:25:50PM -0500, Lee Revell wrote:
> On Thu, 2006-02-02 at 16:09 -0500, Jim Crilly wrote:
> > Apparently O_EXCL was added by Ubuntu and Debian to stop
> > burns being corrupted by hald polling the device while a disc is
> > being burned. 
> 
> IO priorities are the correct solution...
> 
> Lee

Is this something that's available now?

Jim.
