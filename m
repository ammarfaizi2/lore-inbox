Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267671AbTASQ5E>; Sun, 19 Jan 2003 11:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267672AbTASQ5E>; Sun, 19 Jan 2003 11:57:04 -0500
Received: from mail1.bluewin.ch ([195.186.1.74]:13184 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id <S267671AbTASQ5D>;
	Sun, 19 Jan 2003 11:57:03 -0500
Message-ID: <3E2ADACA.5050404@linkvest.com>
Date: Sun, 19 Jan 2003 18:05:14 +0100
From: Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Disabling file system caching 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Is it possible to disable file caching for a given partition or mount?
Or at least to limit it at a certain quantity of memory?
I think of a BIG compilation (several GB of files) and would tell gcc to 
not cache the compiled files.
Thanks
-jec


