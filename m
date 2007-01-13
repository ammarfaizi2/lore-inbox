Return-Path: <linux-kernel-owner+w=401wt.eu-S1161189AbXAMAZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161189AbXAMAZr (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 19:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161188AbXAMAZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 19:25:47 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:33011 "HELO
	mustang.oldcity.dca.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1161189AbXAMAZq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 19:25:46 -0500
Subject: Re: list_del corruption with fedora 6 kernels (fc5 was ok)
From: Lee Revell <rlrevell@joe-job.com>
To: Karl Kiniger <karl.kiniger@med.ge.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20070112233400.GA17470@wszip-kinigka.euro.med.ge.com>
References: <20070112233400.GA17470@wszip-kinigka.euro.med.ge.com>
Content-Type: text/plain
Date: Fri, 12 Jan 2007 19:27:30 -0500
Message-Id: <1168648050.3579.45.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2007-01-13 at 00:34 +0100, Karl Kiniger wrote:
> how to track this down?

Reproduce it with an untainted kernel (no nvidia or vmware modules) and
repost.

Lee

