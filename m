Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265127AbUGGNd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUGGNd6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 09:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265134AbUGGNd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 09:33:57 -0400
Received: from mail.3miasto.net ([153.19.176.2]:37614 "EHLO serwer.3miasto.net")
	by vger.kernel.org with ESMTP id S265127AbUGGNdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 09:33:52 -0400
Date: Wed, 7 Jul 2004 15:33:46 +0200 (CEST)
From: Leszek <leszek@serwer.3miasto.net>
To: linux-kernel@vger.kernel.org
Subject: compilation warning in 2.6.7
Message-ID: <Pine.NEB.4.60.0407071528060.25796@serwer.3miasto.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gcc 2.95.4  ( Debian Woody's default ) , kernel 2.6.7 from kernel.org 
gives me the following compilation warning:

fs/smbfs/file.o
   in function smb_file_sendfile
   line 274: unknown conversion type character 'z' in format

Please CC me in your answers as I am not subscribed to the list.

My config file can is here:

www.3miasto.net/~leszek/config.html

Leszek Koltunski
