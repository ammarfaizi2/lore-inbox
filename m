Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265037AbSJWOza>; Wed, 23 Oct 2002 10:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265036AbSJWOz3>; Wed, 23 Oct 2002 10:55:29 -0400
Received: from trappist.elis.rug.ac.be ([157.193.67.1]:28642 "EHLO
	trappist.elis.rug.ac.be") by vger.kernel.org with ESMTP
	id <S265034AbSJWOz2>; Wed, 23 Oct 2002 10:55:28 -0400
Date: Wed, 23 Oct 2002 17:01:32 +0200 (CEST)
From: Frank Cornelis <fcorneli@elis.rug.ac.be>
To: linux-kernel@vger.kernel.org
cc: Frank Cornelis <fcorneli@trappist.elis.rug.ac.be>
Subject: [PATCH] extended ptrace
Message-ID: <Pine.LNX.4.44.0210231656080.19811-100000@trappist.elis.rug.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A new extended ptrace patch is available at:
	http://www.elis.rug.ac.be/~fcorneli/downloads/devel/exptrace-0.3.1.patch.gz

This one has the PTRACE_READDATA, PTRACE_WRITEDATA and PTRACE_DUMPCORE 
ptrace requests from SunOS along with faster ptrace_readdata and 
ptrace_writedata functions and some other extended ptrace functionality 
I need. It's patched against 2.4.19.
Since some people often talked about it, I thought some will like this.

Feedback is very welcome. Please CC me.

Frank.

