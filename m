Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262575AbTCRQn0>; Tue, 18 Mar 2003 11:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262576AbTCRQn0>; Tue, 18 Mar 2003 11:43:26 -0500
Received: from lewis.CNS.CWRU.Edu ([129.22.104.62]:24300 "EHLO
	lewis.CNS.cwru.edu") by vger.kernel.org with ESMTP
	id <S262575AbTCRQnZ>; Tue, 18 Mar 2003 11:43:25 -0500
Date: Tue, 18 Mar 2003 11:54:53 -0500
From: Justin Hibbits <jrh29@po.cwru.edu>
Subject: System.map doesn't match running kernel
To: linux-kernel@vger.kernel.org
Message-id: <20030318165453.GA522@lothlorien.cwru.edu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to build the DRI modules for kernel 2.4.20(xfs patched) but ran into
some problems.  Everything compiles fine, but it won't load, due to unresolved
symbols.  All the symbols match in my System.map file, but not with the kernel,
which were both created during the same build.  Not sure what's going on, as
everything worked perfectly fine with 2.4.18 (xfs patched...) and the same
driver package.  Any ideas?  Need more info (like the unresolved symbols,
ksyms, System.map)?

Thanks,
Justin Hibbits

-- 
Registered Linux user 260206


