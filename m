Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267968AbUHLBY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267968AbUHLBY4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 21:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268312AbUHLBYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 21:24:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33664 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267968AbUHLBXe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 21:23:34 -0400
Date: Wed, 11 Aug 2004 21:23:19 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: Kurt Garloff <kurt@garloff.de>
cc: Chris Wright <chrisw@osdl.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] [LSM] Rework LSM hooks
In-Reply-To: <20040811222213.GB14744@tpkurt.garloff.de>
Message-ID: <Xine.LNX.4.44.0408112120320.15343-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2004, Kurt Garloff wrote:

> The rest of the path is still a win IMVHO.
> 
> Unfortunately, it has not been discussed here yet.

Defaulting to the capability module is a separate discussion.  I
personally don't have a strong opinion on this issue.

Chris, Stephen, Greg? :-)



- James
-- 
James Morris
<jmorris@redhat.com>


