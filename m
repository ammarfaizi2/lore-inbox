Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312289AbSCTXib>; Wed, 20 Mar 2002 18:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312279AbSCTXiV>; Wed, 20 Mar 2002 18:38:21 -0500
Received: from mx12.nameplanet.com ([62.70.3.42]:40721 "HELO
	mx12.nameplanet.com") by vger.kernel.org with SMTP
	id <S312289AbSCTXiN>; Wed, 20 Mar 2002 18:38:13 -0500
Date: 20 Mar 2002 23:38:06 -0000
Message-ID: <20020320233806.684.qmail@www4.nameplanet.com>
From: david@shepard.tc
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: smbfs font corruption in 2.5.7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears there were some changes made during 2.5.6 to allow for smbfs unicode
support. The problem appears any time I mount an smb filesystem, whether in X or
at VGA framebuffer console. File and directory names show up in a language I
don't speak. Is there some setting I should change to support unicode now, or is
this a known problem. I haven't seen this reported yet, so...

Thanks in advance,
David Shepard
