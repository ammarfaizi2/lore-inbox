Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUCRNJk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 08:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbUCRNJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 08:09:40 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:6017 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262605AbUCRNJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 08:09:39 -0500
Date: Thu, 18 Mar 2004 13:11:03 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200403181311.i2IDB3dE000721@81-2-122-30.bradfords.org.uk>
To: Felix von Leitner <felix-kernel@fefe.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20040318130640.GA28923@codeblau.de>
References: <20040318130640.GA28923@codeblau.de>
Subject: Re: Remove kernel features (for embedded systems)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And if it is at all possible, I would like to be able to remove parts of
> the IP stack, e.g. routing.  In particular, I would like to be able to
> remove policy routing, if it is at all worth it from the code size point
> of view.

Why not just write your own IP stack in userspace, if you're doing a
heavily embedded system?

John,
