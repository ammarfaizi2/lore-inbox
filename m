Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751475AbVH0QFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbVH0QFK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 12:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbVH0QFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 12:05:10 -0400
Received: from xproxy.gmail.com ([66.249.82.207]:44345 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751475AbVH0QFJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 12:05:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AZRJvNBHNb32Uwu899rzb/mMeIVX8PNLhqesyqdgYffSSJBLrO8gIwiB7oWS6Ku4BZnSpQpc0C5eoZa9LZFVWAkyQirarWnNqqlL2aCsP2HOHMV+bz4GhHM2ARQtvXz+JVWUnqxSkHeUHLLL8ez082/aTkRaOlpk9NcrJjhJMOE=
Message-ID: <1132fcd605082709051c2a7141@mail.gmail.com>
Date: Sun, 28 Aug 2005 00:05:08 +0800
From: lab liscs <liscs.lab@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: when the kernel runs in softirq and tasklet , which context is it in ?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thought it must be in system context ,but always with a litte doubt.

is there third context the kernel can run in ?
