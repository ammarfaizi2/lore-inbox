Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbUL1O67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbUL1O67 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 09:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbUL1O67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 09:58:59 -0500
Received: from sweetums.bluetronic.net ([24.199.150.42]:20360 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S261246AbUL1O65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 09:58:57 -0500
Date: Tue, 28 Dec 2004 09:55:07 -0500 (EST)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Martin Dalecki <martin@dalecki.de>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: lease.openlogging.org is unreachable
In-Reply-To: <B15A995A-57B0-11D9-9777-000A95E3BCE4@dalecki.de>
Message-ID: <Pine.GSO.4.33.0412280951180.6921-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2004, Martin Dalecki wrote:
...
>I don't know of a proper solution, other then writing in big letters
>in the documentation about the circumstances under which you can shoot
>yourself in
>the feet.
>
>Where is NFSv4?

The problem is the protocol, it's the fact that the directory is shared among
more than one machine.  It's the false assumption that a given location is
unique to just one machine.  Yes, I've fallen into this mess too. (And I wasn't
using NFS, btw.)

--Ricky


