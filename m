Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263380AbTCVSPE>; Sat, 22 Mar 2003 13:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263646AbTCVSPE>; Sat, 22 Mar 2003 13:15:04 -0500
Received: from 011.065.dsl.concepts.nl ([213.197.11.65]:5384 "EHLO
	d594e05b.dsl.concepts.nl") by vger.kernel.org with ESMTP
	id <S263380AbTCVSPD>; Sat, 22 Mar 2003 13:15:03 -0500
Subject: request_module status
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1048357521.13938.51.camel@ph58212.pharm.uu.nl>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 22 Mar 2003 19:25:21 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

I've seen several emails (google) telling me request_module() is
supposed to be broken in earlier versions of 2.5.x (e.g.
http://hypermail.idiosynkrasia.net/linux-kernel/archived/2003/week02/0127.html). In 2.5.65, is it still supposed to be broken? The function returns 0 but the module I'm trying to load isn't actually being loaded. In 2.4.20, it works.

Thanks,

Ronald

-- 
Ronald Bultje <rbultje@ronald.bitfreak.net>

