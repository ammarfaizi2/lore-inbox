Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266556AbUAWNud (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 08:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266558AbUAWNud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 08:50:33 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:23936 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S266556AbUAWNuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 08:50:32 -0500
Date: Fri, 23 Jan 2004 13:58:29 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200401231358.i0NDwTOK000745@81-2-122-30.bradfords.org.uk>
To: Evaldo Gardenali <evaldo@gardenali.biz>, linux-kernel@vger.kernel.org
In-Reply-To: <40112465.8040801@gardenali.biz>
References: <40112465.8040801@gardenali.biz>
Subject: Re: buggy raid checksumming selection?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Uhh. correct me if I am wrong, but shouldnt it select the fastest algorithm?

No.  This has been brought up on LKML in the past, search the archives
for extensive discussion of it.

John.
