Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315339AbSEAHwo>; Wed, 1 May 2002 03:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315341AbSEAHwo>; Wed, 1 May 2002 03:52:44 -0400
Received: from vt.fermentas.lt ([193.219.56.32]:13700 "EHLO vt.fermentas.lt")
	by vger.kernel.org with ESMTP id <S315339AbSEAHwn>;
	Wed, 1 May 2002 03:52:43 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: vt <vt@vt.fermentas.lt>
Reply-To: vt@vt.fermentas.lt
Organization: myself
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.11 and smbfs 
Date: Wed, 1 May 2002 09:52:12 +0200
X-Mailer: KMail [version 1.4]
X-Message: There is no virus in this message
X-Apparently-From: Alpha Centauri
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200205010952.12972.vt@vt.fermentas.lt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the same problem here (2.5.12+fb patch).

dmesg says:

smb_retry: successful, new pid=427, generation=2
smb_request: result -104, setting invalid
smb_retry: successful, new pid=430, generation=2
smb_proc_readdir_long: name=\, result=-2, rcls=1, err=2

