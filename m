Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265333AbTBBOvq>; Sun, 2 Feb 2003 09:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265339AbTBBOvq>; Sun, 2 Feb 2003 09:51:46 -0500
Received: from hera.cwi.nl ([192.16.191.8]:22980 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S265333AbTBBOvq>;
	Sun, 2 Feb 2003 09:51:46 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 2 Feb 2003 16:01:09 +0100 (MET)
Message-Id: <UTC200302021501.h12F19Z08332.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, srhaque@iee.org
Subject: Re: [PATCH] NFS dev_t fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Just a thought...did you intend to use two slightly different types for 
    major/minor?

Yes - principle of minimal change.

Andries
