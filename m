Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315091AbSDWHGN>; Tue, 23 Apr 2002 03:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315096AbSDWHGM>; Tue, 23 Apr 2002 03:06:12 -0400
Received: from vger.timpanogas.org ([216.250.140.154]:59040 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S315091AbSDWHGL>; Tue, 23 Apr 2002 03:06:11 -0400
Date: Tue, 23 Apr 2002 00:27:28 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Novell Zenworks for Linux 2.5.8 Patch Posted
Message-ID: <20020423002728.A29108@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



A patch that supports Novell Zenworks on Linux kernel 2.5.8 has
been posted to:

ftp.timpanogas.org:/zenworks/zfdimgkrnlpatch-2.5.8.tar.gz 
ftp.utah-nac.org:/zenworks/zfdimgkrnlpatch-2.5.8.tar.gz 

This patch has some limitations since the AHA142X, AHA1740, etc.
drivers do not compile properly in the 2.5.8 kernel at present.
The struct scatterlist {} has changed, so this release is 
experimental until these drivers are functioning and build
correctly in the main tree.

Jeff V. Merkey


