Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTEMTtD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 15:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbTEMTtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 15:49:03 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:37844 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262386AbTEMTtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 15:49:02 -0400
Date: Tue, 13 May 2003 13:02:57 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Shaheed R. Haque" <srhaque@iee.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix list, v2
Message-Id: <20030513130257.78ab1a2e.akpm@digeo.com>
In-Reply-To: <1052826556.3ec0dbbc1d993@netmail.pipex.net>
References: <1050146434.3e97f68300fff@netmail.pipex.net>
	<1050177383.3e986f67b7f68@netmail.pipex.net>
	<1050177751.2291.468.camel@localhost>
	<1050222609.3e992011e4f54@netmail.pipex.net>
	<1050244136.733.3.camel@localhost>
	<1052826556.3ec0dbbc1d993@netmail.pipex.net>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 May 2003 20:01:44.0255 (UTC) FILETIME=[7A2E6CF0:01C3198A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Shaheed R. Haque" <srhaque@iee.org> wrote:
>
> - Add ability to restrict the the default CPU affinity mask so that 
>  sys_setaffinity() can be used to implement exclusive access to a CPU.

Why is this useful?

