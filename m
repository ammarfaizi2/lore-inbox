Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbUFNLpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUFNLpj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 07:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbUFNLpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 07:45:38 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:48601 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S262450AbUFNLpg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 07:45:36 -0400
Date: Mon, 14 Jun 2004 13:45:26 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Daniel Egger <de@axiros.com>
Cc: P@draigbrady.com, David Woodhouse <dwmw2@infradead.org>,
       linux-kernel@vger.kernel.org, cijoml@volny.cz
Subject: Re: jff2 filesystem in vanilla
Message-ID: <20040614114526.GA11873@wohnheim.fh-wedel.de>
References: <200406041000.41147.cijoml@volny.cz> <F84CE3DA-B605-11D8-B781-000A958E35DC@axiros.com> <1086390590.4588.70.camel@imladris.demon.co.uk> <3F4B6D09-B6CA-11D8-B781-000A958E35DC@axiros.com> <40C58781.1060200@draigBrady.com> <213F9E7F-BD15-11D8-AAF6-000A958E35DC@axiros.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <213F9E7F-BD15-11D8-AAF6-000A958E35DC@axiros.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 June 2004 10:39:05 +0200, Daniel Egger wrote:
> On 08.06.2004, at 11:31, P@draigBrady.com wrote:
> 
> >Can you give more detail on how you were able to "kill a card".
> 
> Write to it every now and then using a touchy filesystem
> like ext2 and it will certainly break.
> 
> As soon as a CF card starts developing bad blocks you better
> (trash-)can them because they're losing reliability very
> quickly.

In other words, there is absolutely no wear-levelling in either the
driver or the card itself.  Good to know.

Jörn

-- 
If you're willing to restrict the flexibility of your approach,
you can almost always do something better.
-- John Carmack
