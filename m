Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129686AbRCAQNF>; Thu, 1 Mar 2001 11:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129694AbRCAQMr>; Thu, 1 Mar 2001 11:12:47 -0500
Received: from cs666825-182.austin.rr.com ([66.68.25.182]:40441 "HELO
	www.quasihorse.com") by vger.kernel.org with SMTP
	id <S129686AbRCAQM3>; Thu, 1 Mar 2001 11:12:29 -0500
Date: Thu, 1 Mar 2001 10:15:50 -0600
From: Phil Carinhas <pac@fortuitous.com>
To: linux-kernel@vger.kernel.org
Subject: mount -loop freezes on 2.4.2
Message-ID: <20010301101550.A1416@bistro.marx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 The following commands lockup on exectution. No logs generated, 
  and there is no way to kill the process:

This is the 2.4.2 kernel running on mandrake 7.2

 mount /iso/Conectiva-61beta.iso /alt -o loop=/dev/loop0
 mount /iso/Conectiva-61beta.iso /alt -o loop


 There is no error reported and the file does fail to mount.
 Works ok with 2.4.1 in read mode.. Riel says it fails in write on 2.4.1
-- 

  -Phil C.
.---------------------------------------------------------
| P. A. Carinhas, Ph.D.        |  pac@fortuitous.com      |
| Fortuitous Technologies Inc. |  http://fortuitous.com   |
| Linux Training Services      |  Tel : 1-512 467-2154    |
| Contract, In-house, & Onsite |  800 : 1-877 467-2154    |
 ---------------------------------------------------------
