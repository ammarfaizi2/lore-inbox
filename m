Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264919AbTAEReL>; Sun, 5 Jan 2003 12:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264920AbTAEReK>; Sun, 5 Jan 2003 12:34:10 -0500
Received: from ulima.unil.ch ([130.223.144.143]:19129 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S264919AbTAEReK>;
	Sun, 5 Jan 2003 12:34:10 -0500
Date: Sun, 5 Jan 2003 18:42:45 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.54 problem with IDE ICH4 and aic7xxx
Message-ID: <20030105174245.GB8840@ulima.unil.ch>
References: <20030105165441.GA8215@ulima.unil.ch> <486950000.1041788147@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <486950000.1041788147@aslan.scsiguy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 05, 2003 at 10:35:47AM -0700, Justin T. Gibbs wrote:
> > Under 2.4.20 it boots perfectly...
> > What I found really strange is the time my IDE take to boot. More than
> > five minutes for thoses lines :
> 
> It's not clear from your report exactly where that delay is occurring.

Oups, sorry ;-)
The delay is in the IDE process, all lines take age to appear...

> Is it just before the Adaptec banner is printed or in the middle
> of the IDE messages?  Does the problem persist if you disable domain
> validation via SCSI-Select on your 29160?

I'll try and report, thank you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
