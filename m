Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbVEaR3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbVEaR3G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 13:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbVEaR3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 13:29:06 -0400
Received: from hummeroutlaws.com ([12.161.0.3]:7940 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S261899AbVEaR2f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 13:28:35 -0400
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Tue, 31 May 2005 13:22:04 -0400
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: mrmacman_g4@mac.com, toon@hout.vanvergehaald.nl, ltd@cisco.com,
       linux-kernel@vger.kernel.org, dtor_core@ameritech.net, 7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Message-ID: <20050531172204.GD17338@voodoo>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	mrmacman_g4@mac.com, toon@hout.vanvergehaald.nl, ltd@cisco.com,
	linux-kernel@vger.kernel.org, dtor_core@ameritech.net, 7eggert@gmx.de
References: <26A66BC731DAB741837AF6B2E29C10171E60DE@xmb-hkg-413.apac.cisco.com> <20050530093420.GB15347@hout.vanvergehaald.nl> <429B0683.nail5764GYTVC@burner> <46BE0C64-1246-4259-914B-379071712F01@mac.com> <429C4483.nail5X0215WJQ@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429C4483.nail5X0215WJQ@burner>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/31/05 01:03:31PM +0200, Joerg Schilling wrote:
> 
> > And why again do you need stable SCSI addresses for my _USB_ drive?
> 
> Well if the udev program was polite to users, it would also support
> to edit /etc/default/cdrecord...... 
> 
> ... if it _really_ does wat you like with /dev/ links, then it has all 
> the information that is needed to also maintain /etc/default/cdrecord

The rules and scripts that udev uses to name things can do anything since
it runs in userland, so udev could easily edit /etc/default/cdrecord if
someone took the time to write the script.

Jim.
