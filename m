Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268216AbUIWSk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268216AbUIWSk4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 14:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268293AbUIWSk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 14:40:56 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:34313 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268216AbUIWSkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 14:40:55 -0400
Message-ID: <9710f526040923114012e9b8b3@mail.gmail.com>
Date: Thu, 23 Sep 2004 13:40:55 -0500
From: Erik Hanson <entaled@gmail.com>
Reply-To: Erik Hanson <entaled@gmail.com>
To: Judith und Mirko Kloppstech <jugal@gmx.net>
Subject: Re: Suggestion for CD filesystem for Backups
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <415204E0.9010203@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <415204E0.9010203@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2004 01:04:00 +0200, Judith und Mirko Kloppstech
<jugal@gmx.net> wrote:
> The data for error correction might be written into a file so that the
> CD can be read using any System, but Linux provides error correction.

You may want to look at parchive, if you havn't already. It does this, is cross-
platform and is in wide use. http://parchive.sourceforge.net/
