Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbTD2X1s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 19:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbTD2X1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 19:27:48 -0400
Received: from [12.47.58.171] ([12.47.58.171]:35287 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261936AbTD2X1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 19:27:48 -0400
Date: Tue, 29 Apr 2003 16:37:05 -0700
From: Andrew Morton <akpm@digeo.com>
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: must-fix list for 2.6.0
Message-Id: <20030429163705.139edbf5.akpm@digeo.com>
In-Reply-To: <200304292322.h3TNMPRa004379@81-2-122-30.bradfords.org.uk>
References: <20030429155731.07811707.akpm@digeo.com>
	<200304292322.h3TNMPRa004379@81-2-122-30.bradfords.org.uk>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Apr 2003 23:40:00.0455 (UTC) FILETIME=[A6577570:01C30EA8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford <john@grabjohn.com> wrote:
>
> Is it too early for a 2.7 outline?

Yes.  Anything which gets booted from 2.6 implicitly gets another run in
2.7, or can be backported later.  Let's keep it tight and not disappear
down ratholes.
