Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261634AbTCTSW4>; Thu, 20 Mar 2003 13:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261635AbTCTSWz>; Thu, 20 Mar 2003 13:22:55 -0500
Received: from fluorine.rno.redundant.com ([12.165.49.2]:4298 "EHLO
	fluorine.rno.redundant.com") by vger.kernel.org with ESMTP
	id <S261634AbTCTSWw>; Thu, 20 Mar 2003 13:22:52 -0500
X-MD5-Cluster-1: 4954326aefbec85469d62d1f4f91ada6
Subject: Re: [kernel.org mirrors] Deprecating .gz format on kernel.org
From: Ryan Finnie <rfinnie@redundant.com>
To: mirrors <mirrors@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3E78D0DE.307@zytor.com>
References: <3E78D0DE.307@zytor.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Mar 2003 10:34:31 -0800
Message-Id: <1048185272.1405.12.camel@dhcp-188.dc.rno.redundant.lan>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-19 at 12:19, H. Peter Anvin wrote:
> Hello everyone,
> 
> At some point it probably would make sense to start deprecating .gz
> format files from kernel.org.

When I started mirroring kernel.org, I was under the assumption that
most of the world was still using .gz for the most part, and we are
under a space constraint that prevents us from having both formats (this
will change once we get the new server for OSS mirrors up and running). 
However, Matt's stats are pretty interesting.  So even though we
probably won't be depricating .gz right now, I've switched over my
mirror from .gz to .bz2.  Peter, mark me (RN-RNO) down as converted.

Now, if only GNU tar would read .gz OR .bz2 format when specifying -z
(my fingers automatically type "tar zxvf", and it will take a long time
to change that.  What is bz2?  j?  That's too hard to remember.)
-- 
Ryan Finnie
Senior System Administrator
Redundant Networks
rfinnie@redundant.com
775-850-4222 x2222
775-771-4472 (Cell)

