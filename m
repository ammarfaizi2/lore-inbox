Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbVIMOH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbVIMOH5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 10:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbVIMOH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 10:07:57 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:35992 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S964783AbVIMOH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 10:07:56 -0400
Date: Tue, 13 Sep 2005 16:07:48 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Mark Hounschell <markh@compro.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: HZ question
In-Reply-To: <4326CAB3.6020109@compro.net>
Message-ID: <Pine.LNX.4.53.0509131606300.13574@gockel.physik3.uni-rostock.de>
References: <4326CAB3.6020109@compro.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2005, Mark Hounschell wrote:

> I need to know the kernels value of HZ in a userland app.

Why?
You are supposed _not_ to know it. If you think you need it, something's
wrong.

Tim
