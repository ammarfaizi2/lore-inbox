Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbUCSU0C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 15:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbUCSU0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 15:26:01 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:35845 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261930AbUCSUZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 15:25:57 -0500
Subject: Re: CDFS
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: root@chaos.analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0403191100030.3154@chaos>
References: <Pine.LNX.4.53.0403191100030.3154@chaos>
Content-Type: text/plain
Message-Id: <1079727889.2735.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Fri, 19 Mar 2004 21:24:49 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-19 at 17:01, Richard B. Johnson wrote:
> Just got a CD/ROM that 'works' on W$, but not Linux.
> W$ `properties` call it 'CDFS'. Is there any such Linux
> support?

AFAICT, in Windows CDFS == ISO-9660, nothing more, nothing less.
However, CDFS.SYS from Windows does have support for propietary Romeo
and Jouliet extensions, which maybe are the culprit of the problem.

