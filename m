Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265726AbUAPTjE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 14:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265732AbUAPTjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 14:39:04 -0500
Received: from bay1-f117.bay1.hotmail.com ([65.54.245.117]:8714 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S265726AbUAPTjB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 14:39:01 -0500
X-Originating-IP: [66.96.64.38]
X-Originating-Email: [highwind747@hotmail.com]
From: "raymond jennings" <highwind747@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: [IDEA] - run-length compaction of block numbers
Date: Fri, 16 Jan 2004 11:38:59 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F117hxeH6PC8MS00006f92@hotmail.com>
X-OriginalArrivalTime: 16 Jan 2004 19:38:59.0969 (UTC) FILETIME=[6372E710:01C3DC68]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any value in creating a new filesystem that encodes long contiguous 
blocks as a single block run instead of multiple block numbers?  A long file 
may use only a few block runs instead of many block numbers if there is 
little fragmentation (usually the case).  Also dynamic allocation of 
inodes...etc.  The details are long; anyone interested can e-mail me 
privately.

_________________________________________________________________
Rethink your business approach for the new year with the helpful tips here. 
http://special.msn.com/bcentral/prep04.armx

