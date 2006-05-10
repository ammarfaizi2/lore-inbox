Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbWEJGUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWEJGUS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 02:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWEJGUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 02:20:17 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:42838 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964823AbWEJGUQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 02:20:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Cy9BoduI/XOmw8H7XUw/5ddgh9lNSLV/ZjsDd93q9ebMbTWoONWWQM64lh90Lcg9J6jLJsYA7IIHNscA7e5xnnEgrFmJJ/d9mFfcEbcJ/Z+xkpAoOgbx77+I5XF5Vq3DS8dUzt83n2L4aLECKTAlBv2gc2N3Tr4nRrACkavkvls=
Message-ID: <bda6d13a0605092320y5cca6e1co2228f52c9777c3b1@mail.gmail.com>
Date: Tue, 9 May 2006 23:20:15 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Not mounting NTFS rw, 2.6.16.1, but does so on 2.6.15
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

which means cannot re-run lilo on my laptop, so Not progressing beyond
2.6.15 until fixed.
Downloading 2.6.16.15 to try that version now.

16kstacks patch was applied (I use ndiswrapper with broadcom drivers loaded).
