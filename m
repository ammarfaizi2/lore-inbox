Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbVDDEKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVDDEKl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 00:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVDDEKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 00:10:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27606 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262003AbVDDEK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 00:10:29 -0400
Date: Mon, 4 Apr 2005 00:10:22 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Dave Airlie <airlied@gmail.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Dave Jones <davej@redhat.com>,
       Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH][SELINUX] Add name_connect permission check
In-Reply-To: <21d7e99705040301366b1064b6@mail.gmail.com>
Message-ID: <Xine.LNX.4.44.0504040004350.3965-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Apr 2005, Dave Airlie wrote:

> On a standard FC3 with selinux enabled, booting the latest -bk breaks
> all my outgoing TCP connections at a guess due to this patch.. this
> probably isn't something that people really want to happen.. or maybe
> Fedora can release an updated policy to deal with it?

You need an updated policy, which you can grab from rawhide for FC3 or via 
CVS at http://selinux.sourceforge.net/



- James
-- 
James Morris
<jmorris@redhat.com>


