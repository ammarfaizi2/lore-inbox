Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265044AbUGCEig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265044AbUGCEig (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 00:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265047AbUGCEig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 00:38:36 -0400
Received: from bay16-f42.bay16.hotmail.com ([65.54.186.92]:12043 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S265044AbUGCEif
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 00:38:35 -0400
X-Originating-IP: [220.224.27.225]
X-Originating-Email: [kartik_me@hotmail.com]
From: "kartikey bhatt" <kartik_me@hotmail.com>
To: jmorris@intercode.com.au, jmorris@redhat.com, linux-kernel@vger.kernel.org
Subject: socket association
Date: Sat, 03 Jul 2004 10:08:34 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY16-F42SHmFssIhJP000042b9@hotmail.com>
X-OriginalArrivalTime: 03 Jul 2004 04:38:34.0618 (UTC) FILETIME=[99A44DA0:01C460B7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sure there is one who will help

in freebsd when a socket is created,
the process  structure of the process creating socket
is passed as an argument to socreate function.
is there any mechanism in linux kernel where we can
associate the process creating socket with the socket.
or we can fetch the process structure of the owning
process given the socket or sock data structure.

--kartikey

_________________________________________________________________
Get Citibank Home Loan ! http://go.msnserver.com/IN/52043.asp At an 
unbelievably low interest rate.

