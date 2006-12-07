Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032115AbWLGMVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032115AbWLGMVQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 07:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032119AbWLGMVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 07:21:15 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:44970 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032115AbWLGMVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 07:21:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=I92kU8hZj8Gj3hHfiY9ujFfCg4AyO0oO//lk6catH4tjaTdcTpIZg9cWY+l1MVWUmLqWloSr8PYMNX6udjm+pGPVOBajS7hi7SLe90OlOcHT9C2DC1QXjGKwtmIqbvzWChS75VzBnjkI5c7XBJOWB2/b5QRohs4p9LyTPZqTlVk=
Message-ID: <aa5953d60612070421j1992fafcvb319d2237201eb3c@mail.gmail.com>
Date: Thu, 7 Dec 2006 17:51:11 +0530
From: "Jaswinder Singh" <jaswinderrajput@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: What happen when hangs !!
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sometimes my machine hangs in userspace area like this :-

VFS: Mounted root (ext3 filesystem).
Freeing init memory: 124K
INIT:
<<HANGS>>

OR

VFS: Mounted root (ext3 filesystem).
Freeing init memory: 124K
INIT: version 2.85 booting
<<RUNNING SMOOTHLY>>

How can I debug this hang, what are the cases.

Is this a deadlock.

Thank you,

Jaswinder Singh.
