Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbWBXHv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbWBXHv2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 02:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWBXHv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 02:51:28 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:44352 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750894AbWBXHv2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 02:51:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sNo491+SjwNwgP44DjyHgsXRo2tnaS4AzmJ0Wr9ehkouuEVlKn1utU1up2nwEGdP03hEHczV/4c6M1kM7nXHthL1Mts+K/6cTXJ5wBW5JiczNLLKy6k+3kmpxRCDiYdWP0yX5shMktUSdUOHZ5LlgmQe7HJmB5psKg5hvs014Fo=
Message-ID: <5be025980602232351k3f6182bbqed5ea54079193953@mail.gmail.com>
Date: Fri, 24 Feb 2006 02:51:27 -0500
From: "Wei Hu" <glegoo@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Looking for a file monitor
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I'm looking for a file monitor for Linux, basically like filemon
(http://www.sysinternals.com/Utilities/Filemon.html) for Windows.  But
it looks like filemon for Linux has been discontinued.

I looked into dnotify but it was not what I'm looking for.  I want a
monitor program that can intercept all file access of any process that
satisfy a given filter.  Is there a program?  I searched on Google but
had no luck.


Thanks,
Wei
