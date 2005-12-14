Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932547AbVLNOxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbVLNOxQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 09:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932609AbVLNOxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 09:53:16 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:10977 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932547AbVLNOxP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 09:53:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=S8guruRY1CLUw21JUwIsrz35IADr57yLHkwu3bC7RfqQvDVb9n6oA0N0Imdyv6r1pdfbT0dsZ+uL5zwJkkGPTwe0FLXRLm+KNxWgAdjnprHGUisGCA6ARgAZ3SYUH8kSmNqt6FqwAUR4nL96nXqCvyBMm9F8il5cI5pLAuaQK5Q=
Message-ID: <100bdf000512140653i4267065du@mail.gmail.com>
Date: Wed, 14 Dec 2005 15:53:14 +0100
From: Aurelyen Tomp <aurelyen.tomp@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Is kgdb available for Sparc ?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hie everyone,

I have just downloaded the kgdb-2-2.6.14 patch for I need
to implement remote debugging of Linux ON A SPARC MACHINE.
Could anyone just tell me : once applied the <core-lite.patch>,
do I also need to write some sparc-specific <sparc.patch>
& <sparc-lite.patch> files ? (...there are none in the kgdb dir.)

Best regards,
A. Tomp

PS : I'm asking this, because I've seen that the downloaded
directory contains several <xyz.patch> & <xyz-lite.patch> files,
where xyz denotes several architecture BUT SPARC... Therefore
I wander if kgdb is available already for SPARC architecture.
