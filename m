Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264510AbTDXXvg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 19:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264522AbTDXXvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:51:20 -0400
Received: from mx01.arcor-online.net ([151.189.8.96]:18308 "EHLO mx01.nexgo.de")
	by vger.kernel.org with ESMTP id S264510AbTDXXqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:46:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Flame Linus to a crisp!
Date: Fri, 25 Apr 2003 01:59:36 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Jamie Lokier <jamie@shareable.org>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <170EBA504C3AD511A3FE00508BB89A9201FD91E8@exnanycmbx4.ipc.com> <20030424214116.097D912EABA@mx12.arcor-online.net> <1051224351.4005.87.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1051224351.4005.87.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030424235817.B25D73BD4F@mx01.nexgo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 25 Apr 03 00:45, Alan Cox wrote:
> On Iau, 2003-04-24 at 22:42, Daniel Phillips wrote:
> > A more mundane goal would be to prevent the 3D driver from letting you
> > see through polygons that are supposed to be opaque.
>
> In the MUD world we solved that by not telling anyone about objects they
> can't see.

Doing the visibility calculations on the server, down to the pixel, is 
possible but not really practical.

Regards,

Daniel
