Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291279AbSBMApr>; Tue, 12 Feb 2002 19:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291278AbSBMApi>; Tue, 12 Feb 2002 19:45:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27398 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291272AbSBMApV>;
	Tue, 12 Feb 2002 19:45:21 -0500
Message-ID: <3C69B71F.E0A940DC@mandrakesoft.com>
Date: Tue, 12 Feb 2002 19:45:19 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Vier <tmv5@home.com>
CC: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: secure erasure of files?
In-Reply-To: <Pine.LNX.4.30.0202121409150.18597-100000@mustard.heime.net> <20020213003649.GA13722@zero>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Vier wrote:
> On Tue, Feb 12, 2002 at 02:12:49PM +0100, Roy Sigurd Karlsbakk wrote:
> > Does anyone know if it'll be hard to enable a <em>secure</em> deletion of
> <snip>
> > Is this hard/possible/doable?
> 
> read:
> 
> http://wipe.sf.net/

The program /usr/bin/shred has existing in GNU fileutils, and thus most
Linux systems, for years and years...

	Jeff



-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
