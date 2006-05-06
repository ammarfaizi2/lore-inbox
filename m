Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWEFGtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWEFGtD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 02:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWEFGtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 02:49:03 -0400
Received: from nz-out-0102.google.com ([64.233.162.199]:46522 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751247AbWEFGtC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 02:49:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qATHgimVleunNq65IsTKHF81Rbp61q8qA3MEP/UPJlttGzbvJpmzBPgP2dpvm+jmaOFeN7JLz9nmMKvbtZpDxRiRKv2DTbIX3kj0V2wOBhW5VqS2Je5l3B9fzGM2sO4uheL0FvgbbRxeibauvZRfIPkmBxFHqa9Fy08vIeoiA2A=
Message-ID: <a63d67fe0605052349p7262214rddbed399e594bc09@mail.gmail.com>
Date: Fri, 5 May 2006 23:49:01 -0700
From: "Dan Carpenter" <error27@gmail.com>
To: linux-kernel@vger.kernel.org, fsmp@freebsd.org
Subject: mptable program
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Pass wrote an mptable program for FreeBSD back in the day.  I
patched it up to compile on 64 bit linux systems.

It's on:
http://smatch.sourceforge.net/upload/mptable.c

Steve has some sample output uploaded here.
http://people.freebsd.org/~fsmp/SMP/mptable/mptable.html

These days most things use ACPI, but it's still pretty useful if you
have to support older software.

regards,
dan carpenter
