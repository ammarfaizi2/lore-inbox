Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUHYVev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUHYVev (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 17:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268991AbUHYVcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 17:32:36 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:42690 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S268825AbUHYVPY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 17:15:24 -0400
Date: Wed, 25 Aug 2004 23:14:53 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Linus Torvalds <torvalds@osdl.org>,
       Daniel Andersen <anddan@linux-user.net>,
       "Sartorelli, Kevin" <Kevin.Sartorelli@openpolytechnic.ac.nz>,
       fraga@abusar.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9-rc1
In-Reply-To: <147680000.1093445547@[10.10.2.4]>
Message-ID: <Pine.LNX.4.61.0408252255320.12756@scrub.home>
References: <4B2093FFC31B7A45862B62A376EA7176033C058D@mickey.topnz.ac.nz><412BE5CC.8020303@linux-user.net>
 <Pine.LNX.4.58.0408241818030.17766@ppc970.osdl.org> <147680000.1093445547@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 25 Aug 2004, Martin J. Bligh wrote:

> My assumption would be that once 2.6.9 is released, it's not uber-stable
> immediately ... so it'd be nice to keep at least one minor rev back
> going on the bugfix stream (eg 2.6.8.X) .... for people who want an 
> uber-stable kernel. Doing more than 1 back would indeed seem 
> counter-productive.

In this case it would make more sense to get 2.6.9.1 released as quickly 
as possible instead of trying to fix old releases.
An important aspect to keep in mind is that 2.6.8.1 is an official release 
and people (which not necessarily read lkml and don't complain yet) expect 
being able to upgrade from one release to the next by applying a single 
incremental patch. Making an official patch release against some earlier 
release will certainly cause confusion.

bye, Roman
