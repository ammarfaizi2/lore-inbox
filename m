Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317668AbSGOWCn>; Mon, 15 Jul 2002 18:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317671AbSGOWCm>; Mon, 15 Jul 2002 18:02:42 -0400
Received: from pieck.student.uva.nl ([146.50.96.22]:41112 "EHLO
	pieck.student.uva.nl") by vger.kernel.org with ESMTP
	id <S317668AbSGOWCl>; Mon, 15 Jul 2002 18:02:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rvandijk@science.uva.nl>
Reply-To: rvandijk@science.uva.nl
Organization: UvA
To: Alan Cox <alan@redhat.com>
Subject: Re: Linux 2.4.19-rc1-ac5
Date: Tue, 16 Jul 2002 00:10:05 +0200
X-Mailer: KMail [version 1.3.2]
References: <200207152148.g6FLm7Q24750@devserv.devel.redhat.com>
In-Reply-To: <200207152148.g6FLm7Q24750@devserv.devel.redhat.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020715220241Z317668-685+9887@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 July 2002 23:48, Alan Cox wrote:
> Linux 2.4.19rc1-ac5

it looks like the file is damaged:

# gzip -t patch-2.4.19-rc1-ac5.gz
gzip: patch-2.4.19-rc1-ac5.gz: invalid compressed data--format violated

waiting for the .bz2 file...

	Rudmer
