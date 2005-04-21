Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVDUBGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVDUBGa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 21:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVDUBGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 21:06:30 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:57540 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261159AbVDUBG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 21:06:29 -0400
Date: Thu, 21 Apr 2005 03:06:24 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove some usesless casts
Message-ID: <20050421010624.GA29755@wohnheim.fh-wedel.de>
References: <20050420065500.GA24213@wohnheim.fh-wedel.de> <4266732A.6050508@lougher.demon.co.uk> <20050420213336.GA22421@wohnheim.fh-wedel.de> <4266C0C3.7070002@lougher.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4266C0C3.7070002@lougher.demon.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 April 2005 21:51:15 +0100, Phillip Lougher wrote:
> Jörn Engel wrote:
> 
> >Your definition of _unnecessary_ casts may differ from mine.
> >Basically, every cast is unnecessary, except for maybe one or two - if
> >that many.
> 
> Well we agree to differ then.  In my experience casts are sometimes 
> necessary, and are often less clumsy than the alternatives (such as 
> unions).  This is probably a generational thing, the fashion today is to 
> make languages much more strongly typechecked than before.

I never claimed to replace the casts with unions. ;)

Jörn

-- 
Homo Sapiens is a goal, not a description.
-- unknown
