Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317816AbSGPJAE>; Tue, 16 Jul 2002 05:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317828AbSGPJAC>; Tue, 16 Jul 2002 05:00:02 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:23290 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317816AbSGPI75>; Tue, 16 Jul 2002 04:59:57 -0400
Subject: Re: [RFC] shrink task_struct by removing per_cpu utime and stime
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020716070943.GL1022@holomorphy.com>
References: <20020716070943.GL1022@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 16 Jul 2002 11:12:32 +0100
Message-Id: <1026814352.1687.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A PS: to that. I'm not opposed to removing them. I'd prefer them left
around in the kernel debugging options though

