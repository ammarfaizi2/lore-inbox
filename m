Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVFNKLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVFNKLr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 06:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVFNKLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 06:11:47 -0400
Received: from main.gmane.org ([80.91.229.2]:54461 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261169AbVFNKLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 06:11:45 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Date: Tue, 14 Jun 2005 12:10:46 +0200
Message-ID: <yw1x4qc18d09.fsf@ford.inprovide.com>
References: <f192987705061303383f77c10c@mail.gmail.com> <42AD649E.1020901@stesmi.com>
 <1118685680.18189.3.camel@localhost> <1118741522.9059.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 76.80-203-227.nextgentel.com
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:mLO1z+/LJ+rkQ4w+o3b/y9hJPVE=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Islam Amer <pharon@gmail.com> writes:

> Hi.
> A related issue I had is that some codepages don't have a nls module
> yet. 
> For example I once or twice needed to mount a vfat filesystem with
> cp1256 ( arabic windows ) charset. There is no such nls module. I
> couldn't find any documentation about how to create the module ( maybe I
> didn't look hard enough ).
> Therefore a filesystem used by old windows versions having arabic names
> is unusable.

Did you try looking at some of the already existing ones?

-- 
Måns Rullgård
mru@inprovide.com

