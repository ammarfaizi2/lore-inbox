Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbTKLHaW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 02:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbTKLHaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 02:30:21 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:30663
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S261801AbTKLHaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 02:30:19 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: mzyngier@freesurf.fr
Subject: Re: Why can't I shut scsi device support off in -test9?
Date: Wed, 12 Nov 2003 01:26:59 -0600
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200311120046.04348.rob@landley.net> <wrpr80e84fm.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <wrpr80e84fm.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311120126.59472.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 November 2003 00:51, Marc Zyngier wrote:
> >>>>> "Rob" == Rob Landley <rob@landley.net> writes:
>
> Rob> I go into the scsi menu, but scsi device support isn't an option
> Rob> anymore. It's three dashes, hardwired to on.
>
> Rob> I'm fairly certain my laptop hasn't got any scsi devices in it...
>
> USB storage, maybe ?
>
> 	M.

Nope.  That's off.  (Only enabled USB devices is my scanner.)

I tried switching SCSI support off by hand (editing .config) and it still 
showed up in the menu.  (Maybe turned back on by a dependency, but on what?)

Rob
