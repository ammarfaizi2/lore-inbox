Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263275AbTFXVHS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 17:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263277AbTFXVHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 17:07:18 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:28217 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263275AbTFXVHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 17:07:16 -0400
Date: Tue, 24 Jun 2003 14:22:14 -0700
From: Andrew Morton <akpm@digeo.com>
To: Konstantin Kletschke <konsti@ludenkalle.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: medium Oops on 2.5.73-mm1
Message-Id: <20030624142214.67e5c5f4.akpm@digeo.com>
In-Reply-To: <20030624210414.GA1533@sexmachine.doom>
References: <20030624164026.GA2934@sexmachine.doom>
	<20030624210414.GA1533@sexmachine.doom>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Jun 2003 21:21:25.0016 (UTC) FILETIME=[91162980:01C33A96]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Konstantin Kletschke <konsti@ludenkalle.de> wrote:
>
>  This evening 2.5.73-mm1 "crashed" two times. The " because of that: this
>  time it did not freeze completely, it disabled keyboard and mouse
>  buttons, mouse movements where working still! I was running X...

Please see if it is repeatable without the nVidia driver loaded.
