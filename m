Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbTHTNKk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 09:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbTHTNKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 09:10:40 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:36225 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261953AbTHTNKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 09:10:39 -0400
Date: Wed, 20 Aug 2003 14:22:26 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200308201322.h7KDMQga000797@81-2-122-30.bradfords.org.uk>
To: linux-kernel@vger.kernel.org, spiridonov@gamic.com
Subject: Re: how to turn off, or to clear read cache?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I need to make some performance tests. I need to switch off or to clear 
> read cache, so that consequent reading of the same file will take the 
> same amount of time.
>
> Is there an easy way to do it, without rebuilding the kernel?

Unmount and remount the filesystem.

John.
