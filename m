Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265958AbUAKTDy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 14:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265959AbUAKTDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 14:03:54 -0500
Received: from hera.cwi.nl ([192.16.191.8]:3222 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S265958AbUAKTDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 14:03:53 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 11 Jan 2004 20:03:49 +0100 (MET)
Message-Id: <UTC200401111903.i0BJ3nV06355.aeb@smtp.cwi.nl>
To: aebr@win.tue.nl, sven.kissner@consistencies.net
Subject: Re: logitech cordless desktop deluxe optical keyboard issues
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i'm not a programmer and not quite sure what to do with it..  ;)

Ah, sorry. Put the text (starting with the /* line) in a file
called sk.c. Compile it using the command "cc -Wall sk.c -o sk".
Then invoke it using ./sk, for example "./sk 92 120".

Andries

