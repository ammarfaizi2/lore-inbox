Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbTDQHKo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 03:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbTDQHKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 03:10:44 -0400
Received: from hera.cwi.nl ([192.16.191.8]:39677 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261177AbTDQHKo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 03:10:44 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 17 Apr 2003 09:22:37 +0200 (MEST)
Message-Id: <UTC200304170722.h3H7Mbo06203.aeb@smtp.cwi.nl>
To: 76306.1226@compuserve.com, Andries.Brouwer@cwi.nl
Subject: Re: [PATCH] kill ide-geometry.c, fix boot problems
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I couldn't get rid of the disk manager on an old 486 running RH 5 --
> did I miss something or was it really impossible?

In the beginning it was really difficult.
Later I added the noremap boot option that simplified things.
