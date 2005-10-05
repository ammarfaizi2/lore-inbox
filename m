Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932588AbVJEKah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588AbVJEKah (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 06:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbVJEKah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 06:30:37 -0400
Received: from moraine.clusterfs.com ([66.96.26.190]:47080 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S932588AbVJEKag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 06:30:36 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17219.43860.610103.628963@gargle.gargle.HOWL>
Date: Wed, 5 Oct 2005 14:30:44 +0400
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
In-Reply-To: <20051005095653.GK10538@lkcl.net>
References: <20051002204703.GG6290@lkcl.net>
	<4342DC4D.8090908@perkel.com>
	<200510050122.39307.dhazelton@enter.net>
	<4343694F.5000709@perkel.com>
	<17219.39868.493728.141642@gargle.gargle.HOWL>
	<20051005095653.GK10538@lkcl.net>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke Kenneth Casson Leighton writes:
 > On Wed, Oct 05, 2005 at 01:24:12PM +0400, Nikita Danilov wrote:
 > 
 > > Marc Perkel writes:
 > > 
 > > [...]
 > > 
 > >  > Right - that's Unix "inside the box" thinking. The idea is to make the 
 > >  > operating system smarter so that the user doesn't have to deal with 
 > >  > what's computer friendly - but reather what makes sense to the user. 
 > >  >  From a user's perspective if you have not rights to access a file then 
 > >  > why should you be allowed to delete it?
 > > 
 > > Because in Unix a name is not an attribute of a file.
 >  
 >  there is no excuse.
 > 
 >  selinux has already provided an alternative that is similar to NW
 >  file permissions.

That's exactly the point: Unix file system model is more flexible than
alternatives. So that one can emulate foreign semantics on top of
it. But not other way around.

Nikita.
