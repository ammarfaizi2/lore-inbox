Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264821AbUDWOGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264821AbUDWOGu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 10:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264820AbUDWOGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 10:06:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32682 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264823AbUDWOGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 10:06:25 -0400
Date: Fri, 23 Apr 2004 10:06:22 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Michal Ludvig <mludvig@suse.cz>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto_null autoload
In-Reply-To: <40883663.5020506@suse.cz>
Message-ID: <Xine.LNX.4.44.0404231005130.26066-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2004, Michal Ludvig wrote:

> Hi,
> 
> the attached patch enables autoload of crypto_null module. Please apply.

It would be nice to also have these for:

alias des3_ede des
alias sha384 sha512



- James
-- 
James Morris
<jmorris@redhat.com>


