Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262488AbVAKDAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbVAKDAo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 22:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262639AbVAKC7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 21:59:38 -0500
Received: from colin2.muc.de ([193.149.48.15]:63754 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262488AbVAJTns (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 14:43:48 -0500
Date: 10 Jan 2005 20:43:42 +0100
Date: Mon, 10 Jan 2005 20:43:42 +0100
From: Andi Kleen <ak@muc.de>
To: YhLu <YhLu@tyan.com>
Cc: "'Mikael Pettersson'" <mikpe@csd.uu.se>, jamesclv@us.ibm.com,
       Matt_Domsch@dell.com, discuss@x86-64.org, linux-kernel@vger.kernel.org,
       suresh.b.siddha@intel.com
Subject: Re: 256 apic id for amd64
Message-ID: <20050110194342.GA98279@muc.de>
References: <3174569B9743D511922F00A0C94314230729139F@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174569B9743D511922F00A0C94314230729139F@TYANWEB>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 11:41:02AM -0800, YhLu wrote:
> Please refer the patch.

That's unreadable. Can you generate against a recent BK snapshot
(2.6.10 + latest from ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/) 
and use diff -u  ? 

-Andi
