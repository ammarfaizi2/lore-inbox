Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbTKYKXA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 05:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbTKYKW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 05:22:59 -0500
Received: from [194.118.56.16] ([194.118.56.16]:48335 "EHLO mia.0xff.at")
	by vger.kernel.org with ESMTP id S262228AbTKYKW7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 05:22:59 -0500
Subject: Re: hyperthreading
From: Karl Pitrich <pit@root.at>
To: lgb@lgb.hu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031125094419.GB339@vega.digitel2002.hu>
References: <20031125094419.GB339@vega.digitel2002.hu>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1069755776.2368.259.camel@warp.fabafsc.fabagl.fabasoft.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 25 Nov 2003 11:22:57 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-11-25 at 10:44, Gábor Lénárt wrote:

> A somewhat stupid question from me, but I have no documentation about
> this topic, namely, how can I enable hyperthreading with 2.6.0 test
> kernels?

HT is normally enabled in the machine's bios.
at least on various IBM's.
if i enable HT in my bios, the kernel detects 4 cpu's, 2 otherwise.

/ karl

