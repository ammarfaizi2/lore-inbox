Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264026AbRFEP4U>; Tue, 5 Jun 2001 11:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264024AbRFEP4F>; Tue, 5 Jun 2001 11:56:05 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:9989 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S264023AbRFEPzy>;
	Tue, 5 Jun 2001 11:55:54 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: John Jasen <jjasen1@umbc.edu>
cc: linux-kernel@vger.kernel.org, kdb@oss.sgi.com
Subject: Re: strange network hangs using kdb 
In-Reply-To: Your message of "Tue, 05 Jun 2001 11:20:26 -0400."
             <Pine.SGI.4.31L.02.0106051115190.11523908-100000@irix2.gl.umbc.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 06 Jun 2001 01:55:48 +1000
Message-ID: <18623.991756548@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jun 2001 11:20:26 -0400, 
John Jasen <jjasen1@umbc.edu> wrote:
>When we use kdb on one of the systems, the other system stops receiving
>packets.

man linux/Documentation/kdb/kdb.mm, section Interrupts and KDB.

