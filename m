Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbTFBOyk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 10:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbTFBOyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 10:54:40 -0400
Received: from windsormachine.com ([206.48.122.28]:36367 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S262410AbTFBOyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 10:54:38 -0400
Date: Mon, 2 Jun 2003 11:08:01 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 764] New: btime in /proc/stat wobbles (even over 30 seconds)
In-Reply-To: <205830000.1054566142@[10.10.2.4]>
Message-ID: <Pine.LNX.4.33.0306021107260.31561-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jun 2003, Martin J. Bligh wrote:

>            Summary: btime in /proc/stat wobbles (even over 30 seconds)
>     Kernel Version: 2.5.70 but also in 2.2.20

Happens in 2.4.20 as well, it wobbles by one every couple seconds.

