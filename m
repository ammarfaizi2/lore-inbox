Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264860AbSJPEwX>; Wed, 16 Oct 2002 00:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264869AbSJPEwX>; Wed, 16 Oct 2002 00:52:23 -0400
Received: from adsl-67-64-81-217.dsl.austtx.swbell.net ([67.64.81.217]:6277
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S264860AbSJPEwW>; Wed, 16 Oct 2002 00:52:22 -0400
Subject: Re: [Kernel 2.5] Qlogic 2x00 driver
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: J Sloan <joe@tmsusa.com>
Cc: Michael Clark <michael@metaparadigm.com>,
       Simon Roscic <simon.roscic@chello.at>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3DACEC85.3020208@tmsusa.com>
References: <200210152120.13666.simon.roscic@chello.at>
	 <1034710299.1654.4.camel@localhost.localdomain>
	 <200210152153.08603.simon.roscic@chello.at>
	 <3DACD41F.2050405@metaparadigm.com> <1034740592.29313.0.camel@localhost>
	 <3DACEB6E.6050700@metaparadigm.com>  <3DACEC85.3020208@tmsusa.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1034744295.29307.23.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.2.99 (Preview Release)
Date: 15 Oct 2002 23:58:18 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-15 at 23:35, J Sloan wrote:
> Just to make sure we are on the same page,
> was that LVM1, LVM2, or EVMS?
> 
> Joe
> 
> Michael Clark wrote:
> 


Quick question on this, could this problem be exacerbated, perhaps, by
large pagebuf usage that XFS performs, as well as the FS buffers that it
allocates, since XFS allocates a lot of read/write buffers for logging?




