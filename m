Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbVKUUDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbVKUUDE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 15:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbVKUUDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 15:03:03 -0500
Received: from ns.firmix.at ([62.141.48.66]:32902 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1750898AbVKUUDC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 15:03:02 -0500
Subject: Re: what is our answer to ZFS?
From: Bernd Petrovitsch <bernd@firmix.at>
To: Rob Landley <rob@landley.net>
Cc: Tarkan Erimer <tarkane@gmail.com>, linux-kernel@vger.kernel.org,
       Diego Calleja <diegocg@gmail.com>
In-Reply-To: <200511211252.04217.rob@landley.net>
References: <11b141710511210144h666d2edfi@mail.gmail.com>
	 <20051121124544.9e502404.diegocg@gmail.com>
	 <9611fa230511210619l208b10a8w77aedaa249345448@mail.gmail.com>
	 <200511211252.04217.rob@landley.net>
Content-Type: text/plain
Organization: http://www.firmix.at/
Date: Mon, 21 Nov 2005 21:02:49 +0100
Message-Id: <1132603369.3306.1.camel@gimli.at.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-21 at 12:52 -0600, Rob Landley wrote:
[...]
> couple decades from now.  It's also proposing that data compression and 
> checksumming are the filesystem's job.  Hands up anybody who spots 
> conflicting trends here already?  Who thinks the 128 bit requirement came 
> from marketing rather than the engineers?

Without compressing you probably need 256 bits.

SCNR,
	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services



