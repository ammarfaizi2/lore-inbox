Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263154AbTDVNcm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 09:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbTDVNcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 09:32:42 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:65528 "EHLO gaston")
	by vger.kernel.org with ESMTP id S263154AbTDVNcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 09:32:41 -0400
Subject: Re: 2.4.21-rc1 doesn't build on ppc (6xx/pmac)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: mikpe@csd.uu.se
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       linuxppc-dev@lists.linuxppc.org
In-Reply-To: <16037.17599.400349.292447@gargle.gargle.HOWL>
References: <16037.17599.400349.292447@gargle.gargle.HOWL>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051019079.6075.2.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 22 Apr 2003 15:44:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-04-22 at 15:33, mikpe@csd.uu.se wrote:
> 2.4.21-pre7 built and ran Ok on my PowerMac 4400 with
> CONFIG_6xx=y and CONFIG_ALL_PPC=y.
> 2.4.21-rc1 fails at the end of the build with:

Known problem, a patch is pending for Marcelo, in the meantime,
use the linuxppc trees

Ben.
