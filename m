Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267869AbTCFG2u>; Thu, 6 Mar 2003 01:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267853AbTCFG2t>; Thu, 6 Mar 2003 01:28:49 -0500
Received: from hera.cwi.nl ([192.16.191.8]:39838 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S267858AbTCFG2s>;
	Thu, 6 Mar 2003 01:28:48 -0500
From: Andries.Brouwer@cwi.nl
Date: Thu, 6 Mar 2003 07:39:18 +0100 (MET)
Message-Id: <UTC200303060639.h266dIo22884.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, torvalds@transmeta.com
Subject: Re: 2.5.63/64 do not boot: loop in scsi_error
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> See if this fixes it..

No, I am afraid not. My infinite loop does not pass through
scsi_eh_ready_devs().

Andries
